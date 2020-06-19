/* eslint no-console: 0 */

import App from '../app/App.svelte'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('init_props')
  const data = node.getAttribute('data')
  const app = new App({
    target: document.body,
    props: JSON.parse(data)
  });
  node.remove()

  window.app = app;
})

