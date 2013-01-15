namespace :cloudinary do
  # add the non-image files that you need to host in Cloudinary
  statics = [ 'application.js', 'application.css' ]
  
  task :sync_assets => :environment do
    # precompile assets so that we have minified js
    `bundle exec rake assets:precompile`
    # delete existing files in Cloudinary to avoid duplicates
    statics.each { |f| Cloudinary::Uploader.destroy(f.gsub(".", "_")) }
    # upload files to Cloudinary, where IDs are the filename with "." replaced with "_" and tag them appropriately
    assets = []
    statics.each { |f| assets << Cloudinary::Uploader.upload(File.open("#{Rails.root}/public/assets/#{f}"), :resource_type => :raw, :public_id => f.gsub(".", "_"), :tags => ["static_assets"]) }
    Settings.static_assets = assets
    # delete the precompile directory after uploading
    `rm -rf public/assets`
  end
end
