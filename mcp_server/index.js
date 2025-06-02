import OAuthProvider from "@cloudflare/workers-oauth-provider";

export default new OAuthProvider({
  apiRoute: "/sse",
  apiHandler: {
    async fetch(request, env, ctx) {
      return new Response("MCP /sse endpoint placeholder", { status: 200 });
    }
  }
});
