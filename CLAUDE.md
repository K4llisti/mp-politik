# Internt Direktv (Claude Code)

Du opererar i en delad arkitektur (`mp-ai-wiki`).
Din primära roll, dina systemrestriktioner och ditt operativa schema är definierade i en separat fil för att bibehålla Single Source of Truth (SSOT).

**OBLIGATORISK UPPSTARTSSEKVENS:**
1. Använd verktyget för att läsa `AGENT.md`.
2. Använd verktyget för att läsa `SKILL.md` i sin helhet.
3. Läs slutet av `references/wiki/log.md` för att förstå vad den förra agenten (Gemini eller en tidigare Claude-session) utförde senast.
4. Avvakta användarens nästa instruktion. Skapa inga egna initiativ innan steg 1-3 är slutförda.
