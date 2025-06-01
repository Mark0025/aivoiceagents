# Plan 0.0.3: Current State, Gaps, and Next Steps

## What We Have

- **Chatterbox**: Local repo with all source code, examples, and dependencies.
- **Plans**: plan1.md (detailed, end-to-end architecture and educational notes), plan2v0.01.md (step-by-step, test-driven workflow template).
- **CLI**: shell_history/cli.sh for orchestrating environment setup, commits, and (soon) TTS actions.
- **Python environment**: Set up with uv, ready for local development.

## What We Do Not Have (Yet)

- **Chatterbox fully integrated as the core TTS module in the CLI**
- **A working TTS command in the CLI that calls Chatterbox and outputs audio**
- **Automated plan-to-code workflow (e.g., NLTK-powered)**
- **Automated versioning and updating of whatsworking.md**
- **API layer (FastAPI) or agent logic beyond TTS**
- **Tests for the CLI and TTS integration**

## Next Steps

1. **Integrate Chatterbox as the core TTS module**
   - Install Chatterbox as an editable package in the environment
   - Add a tts command to the CLI that calls a Python script using Chatterbox
2. **Test the TTS CLI command**
   - Ensure it generates audio from text input
   - Document the process in whatsworking.md
3. **Iterate on CLI features**
   - Add plan-to-code automation (NLTK)
   - Add versioning and documentation automation
4. **Expand app features**
   - Add API layer, agent logic, and tests as described in plan1.md

## Immediate Action

- Focus on making Chatterbox the core module and verifying TTS works via the CLI before expanding further.

---

_This plan is versioned and should be updated (not overwritten) as progress is made._
