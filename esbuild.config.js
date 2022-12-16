#!/usr/bin/env node

var watch = process.argv.includes("--watch");

require('esbuild').build({
  entryPoints: ["app/javascript/application.js", "app/javascript/streaming.js"],
    bundle: true,
  outdir: "app/assets/builds/",
    plugins: [require('esbuild-svelte')()],
    logLevel: "info",
  watch: watch,
  loader: {
    '.png': 'file',
    '.svg': 'file'
  },
}).catch(() => process.exit(1));
