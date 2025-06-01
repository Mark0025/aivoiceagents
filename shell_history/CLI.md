# Project CLI Tool

This CLI orchestrates all major project actions.  
Below are the available commands:

| Command                            | Description                                                  |
| ---------------------------------- | ------------------------------------------------------------ |
| `condaenv`                         | Create and activate micromamba env with Python 3.10          |
| `deps`                             | Install all dependencies and Chatterbox (micromamba + pip)   |
| `env`                              | Set up Python environment using uv                           |
| `gen <desc>`                       | Generate code or file from description (placeholder)         |
| `test`                             | Run tests (placeholder)                                      |
| `version`                          | Version outputs (placeholder)                                |
| `record <output.wav> [duration]`   | Record audio from MacBook Pro Microphone (default 5s)        |
| `tts <text> [--audio-prompt path]` | Generate TTS audio from text using Chatterbox                |
| `createmcp`                        | Scaffold a Cloudflare Worker MCP server for your voice agent |
| `commit <msg>`                     | Commit and push with message                                 |
| `startserver`                      | Start the FastAPI TTS server on port 9010                    |
| `stopserver`                       | Stop the FastAPI TTS server (uvicorn)                        |
| `help`                             | Show this help menu                                          |

## Usage

```sh
./shell_history/cli.sh <command> [args]
```

For example, to start the TTS server:

```sh
./shell_history/cli.sh startserver
```
