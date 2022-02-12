const { environment } = require('@rails/webpacker')
const svelte = require('./loaders/svelte')
const webpack = require("webpack") 

environment.loaders.prepend('svelte', svelte)
environment.plugins.append("Provide", new webpack.ProvidePlugin({ 
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))  

module.exports = environment
