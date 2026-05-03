# Convert — Ingest-katalog för pre-processing

Lägg filer som ska konverteras här. Agenten läser härifrån vid `Konvertera [filnamn]`.

**Flöde:** `convert/` → (LLM konverterar) → `raw/[underkatalog]/`

## Vad som hanteras
- PDF-dokument (partiprogramspdf, motions-PDF, pressmeddelanden)
- Word-dokument (.docx)
- Textfiler som behöver struktureras med rubriker och block-id:n

## OBS
- Filer raderas INTE härifrån automatiskt — du rensar manuellt efter att konverteringen verifierats
- Den konverterade filen i `raw/` är den auktoritativa källan och ändras aldrig
