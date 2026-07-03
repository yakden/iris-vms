# Iris — End-User Licence Agreement (EULA)

**Version 1.0 · Effective 2 July 2026**

This End-User Licence Agreement ("**Agreement**") is a legally binding contract between the applicable **Licensor** — determined by the Licensee's location under §15 and identified on the order form — and the customer ("**Licensee**", "**you**"). The Licensor is one of:

- **For international / EU customers (governed by §15.1):** **Sergey Gnatyuk**, a sole proprietor (*jednoosobowa działalność gospodarcza*) registered in CEIDG (Poland) since 01.08.2023, **NIP 9592064173**, **REGON 525970500**, registered office at [address — to be completed]; and
- **For customers in the Russian Federation / CIS (governed by §15.2):** **Individual Entrepreneur (ИП) Gnatyuk Sergey Valentinovich**, **OGRNIP 325619600231870**, **INN 614329780763**, registered office at [address — to be completed]

(each, "**Licensor**", "**we**", "**us**"). The **Licensee** ("**you**") is the natural or legal person that installs, activates, accesses, or uses the Software.

**PLEASE READ THIS AGREEMENT CAREFULLY.** By clicking "I accept", installing, activating, or using the Software, you confirm that you have read, understood, and agree to be bound by this Agreement. **If you do not agree, do not install, activate, or use the Software.** If you accept on behalf of an organisation, you represent that you are authorised to bind that organisation, and "you" refers to that organisation.

This Agreement is published in **English and Russian**. Both versions are available at <https://docs.iris.monmyip.io/legal/EULA/>. The governing-language rule is set out in §17.

---

## 1. Definitions

- **"Software"** — the Iris on-premises video-management and AI-analytics system, in object-code / container-image form, together with its updates, tools, and accompanying documentation supplied by Licensor.
- **"Licence File"** — the cryptographically signed entitlement issued by Licensor that identifies the licensed deployment hardware, the permitted number of cameras, the entitlement tier, and the term.
- **"Deployment Hardware"** — the machine(s) identified by hardware fingerprint in the Licence File on which the Software is licensed to run.
- **"Trial"** — the free evaluation licence described in §3.
- **"Biometric Features"** — face recognition, persistent face-anchored cross-camera identities, voice/speaker recognition, and age/gender estimation.
- **"Documentation"** — the user and deployment documentation at <https://docs.iris.monmyip.io/>.

## 2. Licence grant

2.1 Subject to your continuous compliance with this Agreement and payment of the applicable fees, Licensor grants you a **non-exclusive, non-transferable, non-sublicensable, revocable** licence to install and run the Software on the **Deployment Hardware**, for the **number of cameras and the entitlement tier** stated in the Licence File, for the **subscription term** purchased.

2.2 The licence is **bound to the Deployment Hardware**. Running the Software on non-matching hardware, or beyond the licensed camera count or entitlement tier, is outside the scope of this licence and constitutes a material breach.

2.3 All rights not expressly granted are reserved by Licensor. This Agreement grants a **licence to use**, not a sale of, the Software.

## 3. Free trial / evaluation licence

3.1 Where offered, Licensor may grant a **free evaluation ("Trial") licence** valid for a **fixed period of seven (7) days** from activation. The Trial:

(a) unlocks the **full feature set** and is provided for evaluation only; it is **not** a warranty or representation of fitness (see §11);

(b) is **bound to the evaluation hardware** and limited to **one (1) Trial per machine** (keyed to the hardware's GPU identity); attempts to reset, clone, virtualise around, or otherwise obtain multiple Trials on the same or substantially similar hardware are not licensed and are a breach of §4;

(c) is **online-only**: it requires periodic successful check-in with Licensor's licence server, carries **no standing offline grace period**, will **cease to operate without connectivity**, and **automatically expires at the end of the seven (7)-day period**, whether or not online;

(d) confers **no right to continued use** after expiry; continued use requires a purchased licence under §2; and

(e) is **revocable at any time** at Licensor's discretion and is otherwise subject to all terms of this Agreement.

3.2 By installing or activating the Software in Trial mode, you **acknowledge and accept** the 7-day, online-only, one-per-machine nature of the Trial.

## 4. Restrictions

You shall not, and shall not permit or enable any third party to:

(a) reverse engineer, decompile, disassemble, or otherwise attempt to derive the source code, underlying ideas, or algorithms of the Software, **except** to the limited extent this restriction is expressly prohibited by applicable mandatory law (and then only after prior written notice to Licensor);

(b) remove, disable, bypass, or circumvent any licence-enforcement, integrity-verification, or **code-protection** mechanism, or any technical measure limiting cameras, tier, term, or hardware binding;

(c) copy (except one back-up copy for archival purposes), resell, rent, lease, lend, sublicense, distribute, host as a service, or otherwise make the Software available to any third party;

(d) use the Software beyond the licensed cameras, entitlement tier, or term;

(e) use the Software in any manner that violates applicable law, including data-protection, biometric-privacy, surveillance, telecommunications-interception, and export/sanctions law; or

(f) use the Software to develop a competing product, or publish benchmarks of it, without Licensor's prior written consent.

## 5. Third-party components & AI models (pass-through)

5.1 The Software may load AI models and incorporate open-source components supplied by third parties. **Detection-only is the default configuration.**

5.2 Open-source components are licensed to you under their respective licences, as listed in the distributed `THIRD_PARTY_NOTICES`. In the event of a conflict, those third-party licences govern that component.

5.3 You are responsible for ensuring you hold all licences required for any model you enable. In particular, certain **face-recognition models (e.g. InsightFace `buffalo_l`) are licensed by their authors for non-commercial use only**; to enable face recognition for a commercial purpose you must obtain your own **commercial face-model licence** or supply your own lawfully licensed model pack. Licensor grants no rights in third-party models beyond those the third party grants.

## 6. Biometric & AI features — opt-in; Licensee responsibility

6.1 The Software ships with **Biometric Features disabled** (`biometrics_enabled=false`): face recognition, persistent face-anchored identities, voice/speaker recognition, and age/gender estimation are **off** by default.

6.2 If you **enable** any Biometric Feature, you act as the **data controller** and are solely responsible for: establishing a **lawful basis** for biometric processing (e.g. **explicit consent** under GDPR Art. 9, **written consent** under US BIPA, and consent/notification under Russian Federal Laws No. 152-FZ and No. 572-FZ); providing all required notices; carrying out a **Data Protection Impact Assessment (DPIA)** where applicable; setting retention and destruction policies; and discharging any **EU AI Act** deployer obligations (biometric identification may constitute a high-risk AI use).

6.3 **Audio / speech-to-text.** You are responsible for compliance with audio-recording and interception laws, including **all-party-consent** jurisdictions and voice-as-biometric rules (e.g. RU 572-FZ). The Software provides controls to disable audio capture.

6.4 You shall **not** use the Software for any purpose prohibited by the EU AI Act or other applicable law, including unlawful real-time remote biometric identification in publicly accessible spaces, social scoring, or unlawful covert surveillance.

6.5 **Because the Software runs entirely on your hardware and Licensor has no access to your configuration or data (see §7), enabling and operating Biometric Features is entirely within your control and responsibility.**

## 7. Data protection; on-premises; no Licensor processing

7.1 The Software runs **on your hardware**. **Licensor does not access, receive, store, or process your video, audio, biometric, or personal data.**

7.2 The optional licence heartbeat and update check transmit to Licensor **only** the licence id, the Deployment Hardware fingerprint, the Software version, and health/liveness status — **no personal data and no captured media**.

7.3 You are the **sole controller** of all data captured or processed by the Software. Because Licensor performs no processing of your data, **no Licensor-side data-processing agreement is required** for the on-premises deployment; any processing agreements you require with your own personnel or sub-processors are your responsibility.

## 8. Export controls & sanctions

8.1 Each party represents that it is **not** a sanctioned or restricted party under the lists of the EU, the United States (OFAC), the United Kingdom, or the United Nations, and is not owned or controlled by such a party.

8.2 You shall comply with all applicable **export-control and sanctions** laws and shall not use, export, re-export, or transfer the Software in violation of them.

8.3 Licensor may suspend or terminate this Agreement, without liability, where performance would breach applicable sanctions or export-control law.

8.4 **Russia / CIS supply.** The parties acknowledge that cross-border supply may be subject to EU and other export controls; supply into Russia and the CIS is made through the structure and under the additional terms identified in the applicable order form or reseller agreement.

## 9. Updates & subscription

9.1 During the paid subscription period Licensor provides updates via **signed release manifests** (with anti-rollback protection).

9.2 After the subscription expires the Software **continues to run offline** on the last-installed version (no remote disabling of a paid, perpetually-licensed deployment); new updates require renewal. Paid-licence enforcement includes a reasonable **offline grace period** (the Trial under §3 does not).

## 10. Intellectual property

The Software and all intellectual-property rights in it are and remain the exclusive property of Licensor and its licensors. This Agreement does not transfer any ownership. "Iris" and associated marks are the property of Licensor; nothing herein grants you any right to use them except to identify the Software as installed.

## 11. Warranty disclaimer

TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE SOFTWARE IS PROVIDED **"AS IS"** AND **"AS AVAILABLE"**, WITHOUT WARRANTY OF ANY KIND. LICENSOR DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. The Software is a security and analytics **aid, not a guarantee**; Licensor does not warrant uninterrupted or error-free recording, detection, or operation. **AI detection and recognition are probabilistic and may produce false positives and false negatives.** You shall not rely on the Software as the sole basis for any consequential decision about a person. Nothing in this section limits warranties that cannot be excluded under mandatory law (see §16).

## 12. Limitation of liability

12.1 TO THE MAXIMUM EXTENT PERMITTED BY LAW, LICENSOR SHALL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, OR FOR LOSS OF PROFITS, REVENUE, DATA, OR GOODWILL, ARISING OUT OF OR RELATING TO THE SOFTWARE OR THIS AGREEMENT.

12.2 LICENSOR'S TOTAL AGGREGATE LIABILITY ARISING OUT OF OR RELATING TO THIS AGREEMENT SHALL NOT EXCEED THE **FEES PAID BY YOU IN THE TWELVE (12) MONTHS** IMMEDIATELY PRECEDING THE EVENT GIVING RISE TO THE CLAIM.

12.3 **Nothing in this Agreement excludes or limits liability that cannot be excluded or limited under applicable mandatory law**, including liability for death or personal injury caused by negligence, for fraud or fraudulent misrepresentation, or for gross negligence or wilful misconduct.

## 13. Indemnification

You shall defend, indemnify, and hold harmless Licensor against any third-party claim, and any resulting loss, liability, penalty, or cost (including reasonable legal fees), arising from your **unlawful or non-compliant use** of the Software, including biometric, surveillance, or audio processing without a lawful basis or required consent, and breaches of data-protection or export/sanctions law.

## 14. Term & termination

14.1 This Agreement is effective on your acceptance and continues until the subscription expires or it is terminated.

14.2 Licensor may terminate immediately on your material breach, including circumvention of protection or enforcement mechanisms (§4(b)), exceeding the licensed limits, or unlawful use.

14.3 On termination you shall cease all use of the Software and destroy all copies. Data residing on your hardware remains your responsibility. §§4, 5, 6, 8, 10–13, and 15–18 survive termination.

## 15. Governing law & jurisdiction

The following applies **according to the Licensee's principal place of business / residence**, as identified on the order form. Where no election is made, §15.1 (EU variant) applies.

**15.1 EU / international variant.** This Agreement is governed by the laws of **Poland**, excluding its conflict-of-laws rules and the United Nations Convention on Contracts for the International Sale of Goods (CISG). The courts of **Warsaw, Poland** have exclusive jurisdiction, subject to any mandatory consumer-protection rules of the Licensee's country of habitual residence.

**15.2 Russia / CIS variant.** For a Licensee established or resident in the Russian Federation or the CIS, this Agreement is governed by the substantive law of the **Russian Federation**, and disputes are subject to the competent court at the **Licensor's (or its authorised reseller's) place of business**, subject to applicable mandatory consumer-protection and currency-control law. Supply is subject to §8.4.

**15.3 US note (BIPA).** Where the Software is used in the United States, the Software ships without biometric capture enabled; any biometric use is the Licensee's responsibility under the Illinois Biometric Information Privacy Act (740 ILCS 14 et seq.) and comparable state laws.

## 16. Consumers; mandatory rights

If you are a **consumer**, you retain all rights granted to you by the mandatory consumer-protection law of your country of habitual residence, and nothing in this Agreement (including §§11, 12, and 15) limits those rights. The disclaimers and limitations above apply only to the extent permitted by that law.

## 17. Language

This Agreement is provided in **English and Russian**. For a Licensee governed by §15.1, the **English** version prevails in the event of any discrepancy. For a Licensee governed by §15.2, the **Russian** version prevails. Each translation is provided for convenience and is intended to have the same legal meaning.

## 18. Miscellaneous

18.1 **Entire agreement.** This Agreement, together with the applicable order form and Licence File, is the entire agreement between the parties on its subject matter and supersedes all prior understandings.

18.2 **No waiver.** A failure to enforce a provision is not a waiver of it.

18.3 **Severability.** If any provision is held unenforceable, the remainder stays in force and the provision is reformed to the minimum extent necessary.

18.4 **Assignment.** You may not assign this Agreement without Licensor's prior written consent; Licensor may assign it to an affiliate or successor.

18.5 **Force majeure.** Neither party is liable for delay or failure caused by events beyond its reasonable control.

18.6 **Notices.** Legal notices to Licensor shall be sent to **legal@iris.monmyip.io** (and, where a postal address is stated in the order form, in writing to that address).

## 19. Contact

**Licensor (EU / international):** Sergey Gnatyuk, sole proprietor (CEIDG, Poland), NIP 9592064173, REGON 525970500. **Licensor (RU / CIS):** IP Gnatyuk Sergey Valentinovich, OGRNIP 325619600231870, INN 614329780763. **Legal notices & licence queries:** legal@iris.monmyip.io · **Documentation & support:** <https://docs.iris.monmyip.io/>

---

*Annexes forming part of the licensing package where applicable: `THIRD_PARTY_NOTICES`, the customer-facing privacy notice, any regional data-protection rider, and the order form (cameras / tier / term / price).*
