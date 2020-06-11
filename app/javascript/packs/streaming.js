/* eslint no-console: 0 */

import App from '../app/App.svelte'

document.addEventListener('DOMContentLoaded', () => {
  const app = new App({
    target: document.body,
    props: {
      patreonRedirect: process.env.PATREON_REDIRECT,
      patreonClientId: process.env.PATREON_CLIENT_ID
    }
  });

  window.app = app;
})

