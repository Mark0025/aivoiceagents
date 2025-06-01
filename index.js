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
  apiHandler: {
    async fetch(request, env, ctx) {
      return server.fetch(request, env, ctx);
    }
  },
  defaultHandler: GitHubHandler,
  authorizeEndpoint: "/authorize",
  tokenEndpoint: "/token",
  clientRegistrationEndpoint: "/register",
}); 