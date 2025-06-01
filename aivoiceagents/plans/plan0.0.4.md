# Plan 0.0.4: Integrate TTS/Agent Logic into Remote MCP Server

## Current State

- Chatterbox TTS (Python) is working locally and via CLI.
- CLI orchestration (cli.sh) is working for TTS, recording, and environment setup.
- MCP server (Cloudflare Worker) is deployed and accessible at https://mcp-server.aireinvestor.workers.dev, but only returns a static message.
- No TTS/agent logic is exposed via the MCP server yet.
- No `/sse` endpoint or MCP tool listing is available.

## What's Working

| Component               | Status     | Notes                                      |
| ----------------------- | ---------- | ------------------------------------------ |
| Chatterbox TTS (Python) | ✅ Working | CLI and script-based TTS/voice cloning     |
| CLI Orchestration       | ✅ Working | Shell commands for all major actions       |
| MCP Server Deployed     | ✅ Working | Static response only                       |
| MCP Tool Exposure       | ❌ Missing | Need to add TTS tool to Worker             |
| MCP `/sse` Endpoint     | ❌ Missing | Not yet implemented                        |
| MCP Client Integration  | ❌ Missing | Not yet testable with Inspector/Playground |

## Next Steps

1. Integrate TTS logic into MCP server (index.js) using @modelcontextprotocol/sdk.
2. Expose a TTS tool via the MCP protocol and `/sse` endpoint.
3. Test with MCP Inspector/AI Playground.
4. Document and iterate.

## High-Level Architecture

```mermaid
flowchart TD
    subgraph Local
        CLI[CLI (cli.sh/tts.py)]
        ChatterboxTTS[ChatterboxTTS (Python)]
        WAV[my_voice.wav/cli_output.wav]
    end
    subgraph Cloudflare
        Worker[MCP Server (index.js)]
        SSE[/sse endpoint]
    end
    CLI -->|calls| ChatterboxTTS
    ChatterboxTTS -->|generates| WAV
    Worker -->|serves| SSE
    SSE -->|MCP protocol| MCPClient[MCP Client (Claude, Inspector, etc.)]
```

## MCP Server Tool Exposure

```mermaid
graph TD
    Worker[MCP Worker (index.js)]
    SDK[@modelcontextprotocol/sdk]
    TTS[tts.py (Python, local or remote call)]
    Worker --> SDK
    SDK -->|tool: speak| TTS
```

## Implementation Notes

- If TTS cannot run in Worker (Node.js/Workers limitations), call out to a Python backend or API.
- Use `/sse` endpoint for MCP clients.
- Add authentication later if needed.
