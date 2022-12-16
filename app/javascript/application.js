/* eslint no-console: 0 */
// Entry point for the build script in your package.json
import App from './app/App.svelte'

window.addEventListener('load', () => {
  if (t = document.body) {
    const app = new App({
      target: t
    });

    window.app = app;
  }
})
