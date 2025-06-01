export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    // Only handle the /callback route
    if (url.pathname !== "/callback") {
      return new Response("Not found", { status: 404 });
    }

    // Get the code from the query string
    const code = url.searchParams.get("code");
    if (!code) {
      return new Response("Missing code", { status: 400 });
    }

    // Exchange code for access token
    const tokenRes = await fetch("https://github.com/login/oauth/access_token", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        client_id: env.GITHUB_CLIENT_ID,
        client_secret: env.GITHUB_CLIENT_SECRET,
        code,
      }),
    });
    const tokenData = await tokenRes.json();
    if (!tokenData.access_token) {
      return new Response("Failed to get access token", { status: 400 });
    }

    // Fetch user info
    const userRes = await fetch("https://api.github.com/user", {
      headers: {
        "Authorization": `Bearer ${tokenData.access_token}`,
        "User-Agent": "Cloudflare-Worker-MCP"
      }
    });
    const user = await userRes.json();

    // Return a simple success message (customize as needed)
    return new Response(
      `GitHub OAuth Success!<br>User: ${user.login}<br>ID: ${user.id}`,
      { status: 200, headers: { "Content-Type": "text/html" } }
    );
  }
};
