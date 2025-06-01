#!/bin/bash
set -e

cd "$(dirname "$0")"

# 1. Prompt for GitHub OAuth App creation
cat <<EOM
Please create a new GitHub OAuth App at https://github.com/settings/developers with:
  - Application name: MCP Server (production)
  - Homepage URL: https://mcp-server.aireinvestor.workers.dev
  - Authorization callback URL: https://mcp-server.aireinvestor.workers.dev/callback
After creating, copy the Client ID and Client Secret below.
EOM

read -p 'Enter your GitHub OAuth Client ID: ' GITHUB_CLIENT_ID
read -p 'Enter your GitHub OAuth Client Secret: ' GITHUB_CLIENT_SECRET

# 2. Store in .env
cat > .env <<EOL
GITHUB_CLIENT_ID=$GITHUB_CLIENT_ID
GITHUB_CLIENT_SECRET=$GITHUB_CLIENT_SECRET
EOL
echo ".env file created with your GitHub OAuth credentials."

# 3. Export and set as Cloudflare Worker secrets
export $(grep -v '^#' .env | xargs)
echo "Setting Cloudflare Worker secrets..."
echo "$GITHUB_CLIENT_ID" | wrangler secret put GITHUB_CLIENT_ID
echo "$GITHUB_CLIENT_SECRET" | wrangler secret put GITHUB_CLIENT_SECRET

# 4. Install dependencies
echo "Installing dependencies..."
npm install @cloudflare/workers-oauth-provider @modelcontextprotocol/sdk zod

# 5. Scaffold github-handler.js
cat > github-handler.js <<'EOL'
export default {
  async fetch(request, env, ctx) {
    // TODO: Implement GitHub OAuth handler logic here
    return new Response("GitHub OAuth handler placeholder", { status: 200 });
  }
};
EOL

# 6. Scaffold index.js
cat > index.js <<'EOL'
import OAuthProvider from "@cloudflare/workers-oauth-provider";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";
import GitHubHandler from "./github-handler.js";

const server = new McpServer({
  name: "Voice Agent MCP Server",
  version: "0.0.4",
});

server.tool(
  "speak",
  "Synthesize speech from text (stub)",
  { text: z.string() },
  async ({ text }) => {
    return {
      content: [
        { type: "text", text: `TTS would be generated here for: ${text}` },
      ],
    };
  }
);

export default new OAuthProvider({
  apiRoute: "/sse",
  apiHandler: (request, env, ctx) => server.fetch(request, env, ctx),
  defaultHandler: GitHubHandler,
  authorizeEndpoint: "/authorize",
  tokenEndpoint: "/token",
  clientRegistrationEndpoint: "/register",
});
EOL

# 7. Deploy
echo "Deploying Worker..."
wrangler deploy 