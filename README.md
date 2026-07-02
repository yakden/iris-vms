<div align="center">

# Iris — on-prem AI video management (VMS)

**Self-hosted, single-GPU AI video management: real-time detection, event recording, people
analytics, live speech-to-text and a built-in camera security audit — running entirely on your
own hardware. No cloud. Privacy-first.**

[Website](https://iris.monmyip.io) · [Documentation](https://docs.iris.monmyip.io) · [Download](https://iris.monmyip.io/#trial) · [Русская версия](README.ru.md)

</div>

---

Iris turns your RTSP cameras into a real-time AI platform that runs **on one NVIDIA GPU**, on your
premises. Your video, audio and metadata never leave your machine. Detection-only by default;
biometric features are an explicit, consent-gated opt-in.

## Install

> Installing Iris means accepting the [End-User Licence Agreement](EULA.md) ([RU](EULA.ru.md)).
> Leave the licence key blank to start a **free 7-day trial** (online-only).

**Linux** — one command (installs Docker, auto-detects an NVIDIA GPU, loads the image, starts the stack):

```bash
curl -fsSL https://iris.monmyip.io/downloads/iris-install.sh | sudo bash
# with a licence key:
curl -fsSL https://iris.monmyip.io/downloads/iris-install.sh | sudo IRIS_TOKEN=xxxx bash
```

**macOS 12+** — install & start [Docker Desktop](https://www.docker.com/products/docker-desktop), then:

```bash
curl -fsSL https://iris.monmyip.io/downloads/iris-install.sh | bash
```

macOS runs CPU-only (evaluation). GPU (Apple-Silicon) support will follow if there's demand.

**Windows 10/11** — download and run the installer (sets up WSL2 + Docker + NVIDIA automatically):

➡️ **[iris-setup.exe](https://iris.monmyip.io/downloads/iris-setup-1.60.0.exe)** · verify against [SHA256SUMS](SHA256SUMS)

When it finishes, open **http://127.0.0.1:8120**.

## What you get

- 🎯 **Real-time detection & recording** — people, vehicles and more on a non-blocking pipeline; event clips cut from a warm buffer at near-zero CPU.
- 📊 **People analytics** — counting, dwell time, loitering and zone crowd alerts.
- 🗣️ **Live speech-to-text & translation** — real-time subtitles and saved-clip transcripts.
- 🔒 **Built-in camera security audit** — test your own CCTV estate for RTSP/ONVIF/DVRIP/Hikvision/XM weaknesses.
- 🧠 **Cross-camera identities** *(opt-in)* — persistent, face-anchored identities across cameras. Requires your own biometric legal basis and a commercial face-model licence; **off by default**.

## Requirements & disk footprint

| | |
|---|---|
| **OS** | Windows 10 (2004+)/11, Linux x86-64, or macOS 12+ (64-bit) |
| **GPU** | NVIDIA (e.g. T4/L4) — used automatically when present; CPU fallback for evaluation |
| **Disk** | **~15 GB free on Windows, ~12 GB on Linux/macOS** — ~7.5 GB app image + ~0.9 GB AI models + ~3 GB temporary download + room for recordings |

The full footprint ships regardless of which features you enable (disabling a subsystem saves
GPU/CPU at runtime, not disk).

## Privacy, licensing & models

- **On-prem / offline.** Iris runs on your hardware; nothing leaves your premises. The optional
  licence check transmits only a licence id + hardware fingerprint — no personal data.
- **Detection-only by default.** Biometric features (face recognition, voiceprints) are an explicit,
  consent-gated opt-in — GDPR / EU AI-Act / 152-FZ aware. See [docs](https://docs.iris.monmyip.io).
- **Licence-clean models.** The distributed build uses Apache-2.0 / MIT models (RT-DETR detector);
  it carries no AGPL or research-only weights.
- Terms: **[EULA.md](EULA.md)** · **[EULA.ru.md](EULA.ru.md)**. This repository's install scripts are
  MIT (see [LICENSE](LICENSE)); the Iris software itself is licensed under the EULA.

## Manage the stack

After install, from the install directory (`/opt/iris` on Linux, `~/Iris` on macOS):

```bash
docker compose -f docker-compose.yml [-f docker-compose.gpu.yml] ps      # status
docker compose -f docker-compose.yml [-f docker-compose.gpu.yml] logs -f # logs
docker compose -f docker-compose.yml [-f docker-compose.gpu.yml] down    # stop
```

## Links

- 🌐 Website: https://iris.monmyip.io
- 📖 Documentation: https://docs.iris.monmyip.io
- 🔑 Account / licences: https://account.iris.monmyip.io
- 🆘 Support: support@iris.monmyip.io
