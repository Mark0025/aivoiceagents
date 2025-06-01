# Plan 0.0.5: MCP Server Integration & Readiness

## Current State

- CLI tool is robust, versioned, and documented (see CLI.md and cli_commands.json).
- FastAPI TTS backend is scaffolded and can be started/stopped via CLI.
- Chatterbox TTS works locally and via CLI.
- MCP server is deployed to Cloudflare Workers with GitHub OAuth handler scaffolded.
- MCP server exposes `/sse` endpoint and a `speak` tool (currently stub or not fully wired to TTS backend).
- GitHub OAuth secrets are set and handler is implemented.

## What is Working

| Component               | Status     | Notes                                      |
| ----------------------- | ---------- | ------------------------------------------ |
| Chatterbox TTS (Python) | ✅ Working | CLI and script-based TTS/voice cloning     |
| CLI Orchestration       | ✅ Working | Shell commands for all major actions       |
| FastAPI TTS API         | ✅ Working | Can be started/stopped, serves audio files |
| MCP Server Deployed     | ✅ Working | Deployed, OAuth handler present            |
| MCP Tool Exposure       | ⚠️ Partial | `speak` tool not yet wired to TTS backend  |
| MCP `/sse` Endpoint     | ✅ Working | Exposed, but not fully functional          |
| MCP Client Integration  | ❌ Missing | Not yet testable with Inspector/Playground |
| SSL/HTTPS               | ⚠️ Issue   | SSL not working for new subdomain          |

## What is Not Working / Issues

- SSL certificate for new workers.dev subdomain is not active (ERR_SSL_VERSION_OR_CIPHER_MISMATCH).
- MCP server's `speak` tool is not yet calling the FastAPI TTS backend.
- Not yet tested with MCP Inspector or AI Playground.

## What Needs to be Done

- [ ] Ensure MCP server is deployed to the correct Cloudflare account and subdomain.
- [ ] Wait for or resolve SSL provisioning (try redeploy, new subdomain, or contact Cloudflare support if needed).
- [ ] Update MCP server's `speak` tool to call the FastAPI TTS backend and return audio URL.
- [ ] Test MCP server with Inspector/Playground and real agents.
- [ ] Document the full workflow and update plans as needed.

## Next Steps

1. Troubleshoot and resolve SSL issue for workers.dev subdomain.
2. Wire up MCP server's `speak` tool to FastAPI TTS backend.
3. Test end-to-end: MCP client → Worker `/sse` → TTS backend → audio response.
4. Update documentation and plans.
