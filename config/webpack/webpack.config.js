const path    = require("path")
const webpack = require("webpack")

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: {
    application: "./app/javascript/application.js"
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, '..', '..', 'app/assets/builds'),
  },
  module: {
    rules: [
        {
          test: /\.(png|jpe?g|gif|eot|woff2|woff|ttf|svg)$/i,
          use: 'file-loader',
        },
    ],
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ]
}
