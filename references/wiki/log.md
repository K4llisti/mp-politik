# Log — MP Policy Wiki

Append-only händelselogg. Format: `## [YYYY-MM-DD] operation | Beskrivning`
Tip: `grep "^## \[" log.md | tail -10` ger de 10 senaste händelserna.

---

## [2026-05-02] init | Wiki initialiserad
## [2026-05-02] ingest | Partiprogram 2025
## [2026-05-02] ingest | Klimatfärdplan 2021
## [2026-05-02] ingest | Politiskt Handlingsprogram 2026-2030
## [2026-05-02] ingest | Kulturpolitiskt program 2018
## [2026-05-02] lint | Lint-pass slutfört. 
- Auto-fixade: 250+ wikilänkar (prefix 'mp-ai-wiki/' tillagt, wiki-to-wiki korta namn).
- Auto-fixade: 40+ brutna kapitel/sid-länkar mappade till exakta rubriker.
- Fixade: Orphan-sidor (overview.md, log.md) länkade i index.md.
- Flagga: 'politiskt-handlingsprogram-2026-2030.md' har korrupta rubriker (kap 4, 5, 7 saknas/mismatch). Rekommenderar ny Convert-körning.
- Flagga: Block-id #^p14b7 i Klimatfärdplan 2021 är ogiltigt.
## [2026-05-02] convert | Reparation av 'politiskt-handlingsprogram-2026-2030.md'. Semantisk omstrukturering genomförd, rubriker korrigerade (kap 4-7 återställda), och block-id:n synkade med wikin.
## [2026-05-02] convert | Programfördjupning utrikespolitik.pdf
## [2026-05-02] ingest | Programfördjupning utrikespolitik 2026
## [2026-05-02] convert | Miljöpartiets Skogspolitiskta program 2017.pdf
## [2026-05-02] ingest | Skogspolitiskt program 2017
## [2026-05-02] convert | Djurpolitiskt program.pdf
## [2026-05-02] convert | Funktionsrätt - Politik i Livet.pdf
## [2026-05-02] convert | Hälso- och sjukvårdsprogram.pdf
## [2026-05-02] convert | Landsbygdspolitiskt program.pdf
## [2026-05-02] convert | Miljöpartiets antirasistiska handlingsprogram.pdf
## [2026-05-02] convert | program för social rättvisa.pdf
## [2026-05-02] convert | programfordjupning_jamstalldhet.pdf
## [2026-05-02] convert | programfordjupning-ai.pdf
## [2026-05-02] convert | Programfördjupning bostäder.pdf
## [2026-05-02] convert | programfördjupning förnybar energi.pdf
## [2026-05-02] convert | programfördjupning gmo inom jordbruket.pdf
## [2026-05-02] convert | Programfördjupning hav och vatten.pdf
## [2026-05-02] convert | Programfördjupningn biologisk mangfald.pdf
## [2026-05-02] convert | utbildningspolitiskt-program.pdf
## [2026-05-02] ingest | BATCH Grupp A: Social rättvisa, Jämställdhet, Antirasism, Funktionsrätt
## [2026-05-02] ingest | BATCH Grupp B: Biologisk mångfald, Hav och vatten, Djurpolitik, GMO
## [2026-05-02] ingest | BATCH Grupp C: Bostäder, Landsbygd, Förnybar energi
## [2026-05-02] ingest | BATCH Grupp D: Hälso- och sjukvård, Utbildning, AI
## [2026-05-02] lint | 23 auto-fixade, 0 manuella flags. Reparation av kapitelreferenser i sakområdessidor genomförd.

## [2026-05-03] lint | Lint-pass slutfört.
- Fixat: Globalt namnbyte [[Funktionsrätt - Politik i Livet]] -> [[Funktionsrätt - Politik för livet]] i 3 sakområdessidor.
- Fixat: Globalt namnbyte [[Klimatfardplan 2021]] -> [[Klimatfärdplan 2021]] i 5 sidor.
- Fixat: Bruten djuplänk i 'Armlängds avstånd.md' (Partiprogram 2025 kap 8 header).
- Fixat: Bruten djuplänk i 'Energi.md' (Handlingsprogram 2026-2030 kap 1 header).
- Fixat: Orphan-flagga för 'Programfördjupning jämställdhet 2018' åtgärdad genom tillägg i index.md.
- Validerat: Alla block-id:n och resterande rubrik-pekare i sakområden.
