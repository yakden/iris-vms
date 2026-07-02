#!/usr/bin/env bash
# ============================================================================
#  Iris — one-command installer for Linux and macOS.
#
#    curl -fsSL https://iris.monmyip.io/downloads/iris-install.sh | sudo bash
#    # or, with a licence key:
#    curl -fsSL https://iris.monmyip.io/downloads/iris-install.sh | sudo IRIS_TOKEN=xxxx bash
#
#  Installing Iris means accepting the EULA (https://docs.iris.monmyip.io/legal/EULA/).
#  Leave IRIS_TOKEN unset to start the 7-day online-only free trial.
#
#  What it does: verifies free space, installs Docker if needed, downloads and
#  loads the pre-built image (no source), writes the runtime config, starts the
#  stack, fetches the AI models, waits for health, optionally activates the
#  licence, and prints the dashboard URL. No cloud — everything runs locally.
# ============================================================================
set -euo pipefail

VER="1.60.0"
BASE="https://iris.monmyip.io/downloads"
PORTAL="https://account.iris.monmyip.io"
UPDATES="https://updates.iris.monmyip.io"
UI="http://127.0.0.1:8120"
NEED_GB=12                                   # minimum free space to install + run
PUBKEY_N="13338971856913393042619752297780195851314532343737556478323112640979608501257717279303799660905461308813711220051857709314509766437999350721082732705343299246481387232181700934199419135023635235015423525794643836251293276787538009374439080541584039050100173407551032594832120671331993182012462938605852244730043920962352766452253030422778119558395918960221323806038140470920215266833535667278386845293592918997784165315674529881732839921991775519334971561517917919840289468022015629798168267002078478213283079817857247068851022248843179600873919055451707623268980572212624754007299295893118786352229765095829460953387"
PUBKEY_E="65537"

say()  { printf '\033[1;36m>>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31mxx\033[0m %s\n' "$*" >&2; exit 1; }

# --- platform ---------------------------------------------------------------
OS="$(uname -s)"
case "$OS" in
  Linux)  PLATFORM=linux;  WORKDIR="/opt/iris" ;;
  Darwin) PLATFORM=macos;  WORKDIR="$HOME/Iris" ;;
  *) die "Unsupported OS '$OS'. Iris supports Linux and macOS here, and Windows via the .exe installer." ;;
esac

if [ "$PLATFORM" = linux ] && [ "$(id -u)" -ne 0 ]; then
  say "Re-running with sudo (needs root to install Docker and write $WORKDIR)…"
  exec sudo -E bash "$0" "$@"
fi

# --- GPU / variant ----------------------------------------------------------
VARIANT=cpu
if [ "$PLATFORM" = linux ] && command -v nvidia-smi >/dev/null 2>&1; then VARIANT=cuda; fi
say "Platform: $PLATFORM · image variant: $VARIANT"

# --- free-space preflight ---------------------------------------------------
mkdir -p "$WORKDIR"
FREE_KB="$(df -Pk "$WORKDIR" | awk 'NR==2{print $4}')"
FREE_GB=$(( FREE_KB / 1024 / 1024 ))
say "Free space on $(df -Ph "$WORKDIR" | awk 'NR==2{print $6}'): ${FREE_GB} GB"
if [ "$FREE_GB" -lt "$NEED_GB" ]; then
  warn "Iris needs about ${NEED_GB} GB free to install and run (≈7.5 GB image + ~0.9 GB AI models + ~3 GB temporary download + room for recordings)."
  if [ -t 0 ]; then
    read -r -p "Continue anyway? [y/N] " a; [ "${a:-N}" = y ] || [ "${a:-N}" = Y ] || die "Aborted — free up disk space and re-run."
  else
    die "Not enough free disk space (have ${FREE_GB} GB, need ${NEED_GB} GB)."
  fi
fi

# --- Docker -----------------------------------------------------------------
if ! command -v docker >/dev/null 2>&1; then
  if [ "$PLATFORM" = linux ]; then
    say "Installing Docker Engine…"
    curl -fsSL https://get.docker.com | sh
  else
    die "Docker Desktop is required on macOS. Install it from https://www.docker.com/products/docker-desktop , start it, then re-run this installer."
  fi
fi
if ! docker info >/dev/null 2>&1; then
  if [ "$PLATFORM" = linux ]; then
    service docker start 2>/dev/null || systemctl start docker 2>/dev/null || true
  fi
  docker info >/dev/null 2>&1 || die "Docker is installed but not running. Start Docker and re-run."
fi
# compose v2 (plugin) or the legacy binary
if docker compose version >/dev/null 2>&1; then COMPOSE="docker compose"; else COMPOSE="docker-compose"; fi
command -v ${COMPOSE%% *} >/dev/null 2>&1 || die "Docker Compose not found."

# --- NVIDIA Container Toolkit (Linux + GPU) --------------------------------
if [ "$VARIANT" = cuda ] && ! docker info 2>/dev/null | grep -qi nvidia; then
  say "Configuring the NVIDIA Container Toolkit…"
  curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg 2>/dev/null || true
  curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
    | sed 's#deb https#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https#g' \
    > /etc/apt/sources.list.d/nvidia-container-toolkit.list 2>/dev/null || true
  apt-get update -y >/dev/null 2>&1 && apt-get install -y nvidia-container-toolkit >/dev/null 2>&1 \
    && nvidia-ctk runtime configure --runtime=docker >/dev/null 2>&1 \
    && (service docker restart 2>/dev/null || systemctl restart docker 2>/dev/null || true) \
    || warn "Could not auto-configure the NVIDIA toolkit — Iris will still run on CPU."
fi

cd "$WORKDIR"
mkdir -p data models

# --- download + verify + load the image ------------------------------------
TAR="iris-${VER}.tar.gz"
say "Downloading the Iris image (~3 GB, one time)…"
if command -v aria2c >/dev/null 2>&1; then
  aria2c -x16 -s16 -k1M --file-allocation=none -c -o "$TAR" "$BASE/$TAR"
else
  curl -fL -C - -o "$TAR" "$BASE/$TAR"
fi
say "Verifying checksum…"
WANT="$(curl -fsSL "$BASE/SHA256SUMS" | awk -v f="$TAR" '$2==f{print $1}')"
if [ -n "$WANT" ]; then
  if command -v sha256sum >/dev/null 2>&1; then GOT="$(sha256sum "$TAR" | awk '{print $1}')"; else GOT="$(shasum -a 256 "$TAR" | awk '{print $1}')"; fi
  [ "$WANT" = "$GOT" ] || die "Checksum mismatch for $TAR — download corrupted; re-run."
else
  warn "Could not fetch SHA256SUMS — skipping checksum verification."
fi
say "Loading the image into Docker…"
docker load -i "$TAR"

# --- compose files + runtime config ----------------------------------------
say "Fetching compose files…"
curl -fsSL -o docker-compose.dist.yml "$BASE/docker-compose.dist.yml"
curl -fsSL -o docker-compose.gpu.yml  "$BASE/docker-compose.gpu.yml"
COMPOSE_FILES="-f docker-compose.dist.yml"
[ "$VARIANT" = cuda ] && COMPOSE_FILES="$COMPOSE_FILES -f docker-compose.gpu.yml"

if [ ! -f .env ]; then
  say "Writing runtime config (.env)…"
  cat > .env <<EOF
AUTH_REQUIRED=false
DETECTOR_DEVICE=$VARIANT
IRIS_IMAGE_TAG=${VER}-${VARIANT}
IRIS_LICENSE_PUBKEY_N=$PUBKEY_N
IRIS_LICENSE_PUBKEY_E=$PUBKEY_E
TRIAL_AUTO_ENABLED=true
TRIAL_SERVER_URL=$PORTAL
UPDATE_CHECK_ENABLED=true
UPDATE_SERVER_URL=$UPDATES
UPDATE_CHANNEL=stable
EOF
fi

# ownership so the container user (1000:1000) can write data/models
chown -R 1000:1000 data models 2>/dev/null || true

# --- start ------------------------------------------------------------------
say "Starting Iris…"
$COMPOSE $COMPOSE_FILES up -d
# fetch AI models on first run if missing
if [ -z "$(ls -A models 2>/dev/null)" ]; then
  say "Downloading AI models (~0.9 GB, one time)…"
  $COMPOSE $COMPOSE_FILES run --rm vms python3 scripts/download_models.py || warn "Model download failed — retry: cd $WORKDIR && $COMPOSE $COMPOSE_FILES run --rm vms python3 scripts/download_models.py"
  chown -R 1000:1000 models 2>/dev/null || true
  $COMPOSE $COMPOSE_FILES up -d
fi

# --- wait for health --------------------------------------------------------
say "Waiting for Iris to become healthy…"
READY=0
for _ in $(seq 1 60); do
  if curl -fsS "$UI/health" >/dev/null 2>&1; then READY=1; break; fi
  sleep 5
done

# --- optional activation ----------------------------------------------------
if [ "$READY" = 1 ] && [ -n "${IRIS_TOKEN:-}" ]; then
  say "Activating licence…"
  FP="$(curl -fsS "$UI/api/system/license" | sed -n 's/.*"fingerprint"[: ]*"\([^"]*\)".*/\1/p')"
  if [ -n "$FP" ]; then
    if curl -fsS -X POST -H 'Content-Type: application/json' \
         -d "{\"token\":\"$IRIS_TOKEN\",\"hardware\":\"$FP\"}" "$PORTAL/activate" -o data/license.json; then
      chown 1000:1000 data/license.json 2>/dev/null || true
      $COMPOSE $COMPOSE_FILES restart >/dev/null 2>&1 || true
      say "Licence activated."
    else
      warn "Activation failed — you can activate later in the app or at $PORTAL."
    fi
  fi
fi

# --- done -------------------------------------------------------------------
echo
if [ "$READY" = 1 ]; then
  say "Iris is running: $UI"
  [ -z "${IRIS_TOKEN:-}" ] && say "A 7-day free trial has started."
  if   command -v xdg-open >/dev/null 2>&1; then xdg-open "$UI" >/dev/null 2>&1 || true
  elif command -v open     >/dev/null 2>&1; then open "$UI"     >/dev/null 2>&1 || true
  fi
  say "Manage the stack from $WORKDIR:  $COMPOSE $COMPOSE_FILES ps | logs | down"
else
  warn "Iris started but didn't report healthy yet — give it a minute, then open $UI"
  warn "Logs: cd $WORKDIR && $COMPOSE $COMPOSE_FILES logs -f vms"
fi
