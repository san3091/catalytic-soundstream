/* eslint no-console: 0 */

import App from '../app/App.svelte'

document.addEventListener('DOMContentLoaded', () => {
  const app = new App({
    target: document.body,
  });

  window.app = app;
})

