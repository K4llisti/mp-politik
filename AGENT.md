# AGENT.md — Delad Agent-kontext (Mutex Execution)

Denna miljö hanteras asynkront av antingen Gemini CLI eller Claude Code.

## 1. Core Schema
Din hjärna och fullständiga arkitektur finns i `SKILL.md`. Du MÅSTE följa Bento-Box XML-direktiven i den filen.

## 2. State Management (Kritisk)
Eftersom du kan ha startats efter att en annan AI stängts ner, saknar du minne av tidigare sessioner.
- Lita ALLTID på `scripts/metadata_cache.json` framför ditt eget kontext-fönster.
- Om du uppmanas att återuppta en analys, konsultera `references/wiki/log.md` för att hitta tråden.

## 3. Operations
| Operation | Kommando | Regler |
|-----------|----------|--------|
| Convert   | `Convert`| Endast tillåtna skrivningar i `references/raw/`. Måste inkludera Obsidian `^block-id`. |
| Ingest    | `Ingest` | Skapar wikisidor med `mp-ai-wiki/`-prefixade djuplänkar. |
| Query     | [Fråga]  | Syntetisera med in-line citering baserat på `SKILL.md`. |
