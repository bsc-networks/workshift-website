var path = require('path');
var webpack = require('webpack');


//anything not required by this file 
//(or a dependency of something which is required) 
//will never end up in the compiled bundle
var config = module.exports = {
  // the base path which will be used to resolve entry points
  context: path.join(__dirname, '../', '../'),
  // the main entry point for our application's frontend JS
  entry: './app/frontend/javascripts/entry.js',
  
};

config.output = {
  // this is our app/assets/javascripts directory, which is part of the Sprockets pipeline
  path: path.join(config.context, 'app', 'assets', 'javascripts'),
  // the filename of the compiled bundle, e.g. app/assets/javascripts/bundle.js
  filename: 'bundle.js',
  // if the webpack code-splitting feature is enabled, this is the path it'll use to download bundles
  publicPath: '/assets',
  devtoolModuleFilenameTemplate: '[resourcePath]',
  devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]',
};

config.resolve = {
  // tell webpack which extensions to auto search when it resolves modules. With this,
  // you'll be able to do `require('./utils')` instead of `require('./utils.js')`
  extensions: ['', '.js', '.coffee', '.jsx'],
  // by default, webpack will search in `web_modules` and `node_modules`. Because we're using
  // Bower, we want it to look in there too
  modulesDirectories: [ 'node_modules', 'bower_components' ],
};

config.plugins = [
  // we need this plugin to teach webpack how to find module entry points for bower files,
  // as these may not have a package.json file
  new webpack.ResolverPlugin([
    new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('.bower.json', ['main'])
  ]),
  // new webpack.ProvidePlugin({
  //   $: 'jquery',
  //   jQuery: 'jquery',
  // }),
  new webpack.ProvidePlugin({
    React: 'react',
  }),
  //new webpack.optimize.CommonsChunkPlugin('common-bundle.js'),

];

config.module = {
  loaders: [
    { test: /\.coffee$/, loader: 'coffee-loader' },
    {
      test: /\.jsx?$/,
      exclude: /(node_modules|bower_components)/,
      loader: 'babel', // 'babel-loader' is also a legal name to reference
      query: {
        presets: ['react']
      }
    },
  ],
};