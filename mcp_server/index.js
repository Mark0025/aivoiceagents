import OAuthProvider from "@cloudflare/workers-oauth-provider";

const defaultHandler = {
  async fetch(request, env, ctx) {
    return new Response("Not found", { status: 404 });
  }
};

export default new OAuthProvider({
  apiRoute: "/sse",
  apiHandler: {
    async fetch(request, env, ctx) {
      return new Response("MCP /sse endpoint placeholder", { status: 200 });
    }
  },
  defaultHandler
});
