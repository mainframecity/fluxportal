var path = require("path");
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  entry: ["./src/static/index.css", "./src/static/index.js"],
  output: {
    path: path.resolve(__dirname, 'dist/'),
    publicPath: "/assets/",
    filename: "bundle.js"
  },
  module: {
    loaders: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: "elm-webpack-loader?verbose=true&warn=true",
      },
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract(
          { fallback: 'style-loader', use: 'css-loader' }
        )
      },
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        loader: "file-loader"
      }
    ]
  },
  resolve: {
    extensions: [".js", ".elm"]
  },
  plugins: [
    new ExtractTextPlugin("bundle.css")
  ]
}
