import OAuthProvider from "@cloudflare/workers-oauth-provider";

export default new OAuthProvider({
  apiRoute: "/sse",
});
