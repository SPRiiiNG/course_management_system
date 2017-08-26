# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
%w(app lib).each do |d|
  (asset_paths, precompile_paths) = Dir[Rails.root.join(*%W(#{d} assets ** *)).to_s].partition {|f| File.directory?(f) }
  Rails.application.config.assets.paths += asset_paths
  Rails.application.config.assets.precompile += precompile_paths
end

vendor_dirs = Dir[Rails.root.join('vendor/assets/**/*')] - Dir[Rails.root.join('vendor/assets/components/**/*')]
(asset_paths, precompile_paths) = vendor_dirs.partition {|f| File.directory?(f) }
Rails.application.config.assets.paths += asset_paths
Rails.application.config.assets.precompile += precompile_paths
