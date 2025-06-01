#!/bin/bash

# Simple project CLI for orchestrating actions

show_help() {
  echo "Usage: $0 <command> [args]"
  echo "Commands:"
  echo "  condaenv         Create and activate micromamba env with Python 3.10"
  echo "  deps             Install all dependencies and Chatterbox (micromamba + pip)"
  echo "  env              Set up Python environment using uv"
  echo "  gen <desc>       Generate code or file from description (placeholder)"
  echo "  test             Run tests (placeholder)"
  echo "  version          Version outputs (placeholder)"
  echo "  record <output.wav> [duration]  Record audio from MacBook Pro Microphone (default 5s)"
  echo "  tts <text> [--audio-prompt path]  Generate TTS audio from text using Chatterbox, optionally with a reference voice WAV file"
  echo "  createmcp        Scaffold a Cloudflare Worker MCP server for your voice agent"
  echo "  commit <msg>     Commit and push with message"
  echo "  startserver      Start the FastAPI TTS server on port 9010"
  echo "  stopserver       Stop the FastAPI TTS server (uvicorn)"
  echo "  help             Show this help menu"
}

case "$1" in
  condaenv)
    echo "[condaenv] Creating micromamba environment 'aivoiceagents' with Python 3.10..."
    micromamba create -n aivoiceagents python=3.10
    echo "[condaenv] To activate, run: micromamba activate aivoiceagents"
    ;;
  deps)
    echo "[deps] Installing dependencies with micromamba..."
    micromamba install -n aivoiceagents pytorch torchaudio numpy librosa resampy transformers diffusers omegaconf conformer safetensors -c pytorch -c conda-forge
    echo "[deps] Activating environment and installing Chatterbox as editable package..."
    micromamba run -n aivoiceagents pip install -e ./aivoiceagents/chatterbox
    echo "[deps] All dependencies and Chatterbox installed."
    ;;
  env)
    echo "[env] Creating Python virtual environment with uv..."
    uv venv
    echo "[env] Activating environment and installing dependencies..."
    if [ -f requirements.txt ]; then
      . .venv/bin/activate && uv pip install -r requirements.txt
    else
      . .venv/bin/activate
      echo "[env] No requirements.txt found. Environment is ready."
    fi
    ;;
  record)
    shift
    output=${1:-my_voice.wav}
    duration=${2:-5}
    echo "[record] Preparing to record $duration seconds to $output..."
    for i in 3 2 1; do
      echo "[record] Recording starts in $i..."
      sleep 1
    done
    echo "[record] Recording NOW! Speak into your mic..."
    ffmpeg -f avfoundation -i ":1" -t "$duration" -ac 1 -ar 16000 "$output"
    echo "[record] Finished recording. Saved to $output"
    ;;
  gen)
    echo "[gen] Generating code from description: $2 (not implemented yet)"
    ;;
  test)
    echo "[test] Running tests (not implemented yet)"
    ;;
  version)
    echo "[version] Versioning outputs (not implemented yet)"
    ;;
  tts)
    shift
    if [ $# -lt 1 ]; then
      echo "[tts] Usage: $0 tts <text> [--audio-prompt path]"
      exit 1
    fi
    echo "[tts] Generating TTS audio from text: $*"
    micromamba run -n aivoiceagents python tts.py "$@"
    ;;
  createmcp)
    echo "[createmcp] Scaffolding a Cloudflare Worker MCP server in ./mcp_server ..."
    mkdir -p mcp_server
    cat > mcp_server/README.md <<EOL
# Cloudflare MCP Server for Voice Agent

This is a starter template for deploying a Model Context Protocol (MCP) server on Cloudflare Workers. It exposes a TTS tool and supports OAuth authentication.

## Quick Start

1. Install [Wrangler](https://developers.cloudflare.com/workers/wrangler/install/):
   npm install -g wrangler
2. Install dependencies:
   cd mcp_server && npm install
3. Deploy:
   wrangler publish

## References
- https://blog.cloudflare.com/remote-model-context-protocol-servers-mcp/
- https://github.com/cloudflare/ai-agents
EOL
    cat > mcp_server/package.json <<EOL
{
  "name": "mcp-server-voice-agent",
  "version": "0.1.0",
  "type": "module",
  "main": "index.js",
  "dependencies": {
    "@cloudflare/workers-oauth-provider": "^0.1.0",
    "@modelcontextprotocol/sdk": "^0.1.0"
  }
}
EOL
    cat > mcp_server/index.js <<EOL
import OAuthProvider from "@cloudflare/workers-oauth-provider";
// import your TTS logic here

export default new OAuthProvider({
  apiRoute: "/sse",
  apiHandler: async (req, res) => {
    // TODO: Implement TTS tool logic here
    res.json({ message: "MCP server is running!" });
  },
  defaultHandler: async (req, res) => {
    res.json({ message: "OAuth handler placeholder" });
  },
  authorizeEndpoint: "/authorize",
  tokenEndpoint: "/token",
  clientRegistrationEndpoint: "/register",
});
EOL
    echo "[createmcp] Scaffold complete. See ./mcp_server/README.md for next steps."
    ;;
  commit)
    if [ -z "$2" ]; then
      echo "[commit] Error: Commit message required."
      exit 1
    fi
    echo "[commit] Adding all changes..."
    git add .
    echo "[commit] Committing with message: $2"
    git commit -m "$2"
    if [ $? -eq 0 ]; then
      echo "[commit] Pushing to GitHub..."
      git push
      if [ $? -eq 0 ]; then
        echo "[commit] Push successful."
      else
        echo "[commit] Push failed."
      fi
    else
      echo "[commit] Nothing to commit or commit failed."
    fi
    ;;
  startserver)
    echo "[startserver] Starting FastAPI TTS server on port 9010..."
    cd ../tts_api && uvicorn main:app --host 0.0.0.0 --port 9010 &
    cd - > /dev/null
    ;;
  stopserver)
    echo "[stopserver] Stopping FastAPI TTS server (uvicorn)..."
    pkill -f "uvicorn main:app --host 0.0.0.0 --port 9010" || echo "[stopserver] No server process found."
    ;;
  help|*)
    show_help
    ;;
esac 