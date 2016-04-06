namespace :webpack do
  desc 'compile bundles using webpack'
  task :compile do
    cmd = 'webpack --config config/webpack/production.config.js --json'
    output = `#{cmd}`
    puts "Compiling webpack on server"
    stats = JSON.parse(output)

    File.open('./public/assets/webpack-asset-manifest.json', 'w') do |f|
      f.write stats['assetsByChunkName'].to_json
    end
  end
end