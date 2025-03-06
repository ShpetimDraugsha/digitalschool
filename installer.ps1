addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  // Parse the requested URL
  const url = new URL(request.url);
  const path = url.pathname;

  // Serve the PowerShell script only for the /get path
  if (path === '/get') {
    try {
      // Fetch the PowerShell script from GitHub
      const scriptUrl = 'https://raw.githubusercontent.com/ShpetimDraugsha/digitalschool/main/installer.ps1';
      const response = await fetch(scriptUrl);

      // Check if the fetch was successful
      if (!response.ok) {
        throw new Error(`Failed to fetch script: ${response.statusText}`);
      }

      // Get the script content as text
      const scriptContent = await response.text();

      // Return the script with appropriate headers
      return new Response(scriptContent, {
        headers: {
          'Content-Type': 'text/plain',
          'Cache-Control': 'no-store, max-age=0' // Prevent caching for fresh content
        },
        status: 200
      });
    } catch (error) {
      // Handle errors and return a user-friendly response
      return new Response(`Error fetching script: ${error.message}\nPlease check the GitHub URL or try again later.`, {
        headers: { 'Content-Type': 'text/plain' },
        status: 500
      });
    }
  }

  // Return 404 for any other path
  return new Response('Not found. Use /get to access the installer script.', {
    headers: { 'Content-Type': 'text/plain' },
    status: 404
  });
}
