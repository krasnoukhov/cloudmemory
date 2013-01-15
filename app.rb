require "cuba"
require "cuba/render"
require "slim"
require "securerandom"
require "rack/protection"
require "sprockets"
require "sprockets-sass"
require "sass"
require "compass"
require "clogger"
require "instagram"

# Cuba plugins
Cuba.use Rack::Session::Cookie, secret: SecureRandom.hex(64)
Cuba.use Rack::Protection
Cuba.use Clogger, format: :Combined, path: "./log/requests.log", reentrant: true
Cuba.plugin Cuba::Render

# Configuration
Cuba.settings[:render][:template_engine] = :slim
Instagram.configure do |config|
  config.client_id = ENV["INSTAGRAM_KEY"]
  config.client_secret = ENV["INSTAGRAM_SECRET"]
end

# Routes
Cuba.define do
  on root do
    res.write render("views/index.slim")
  end
  
  on "photo/:key/:value" do |key, value|
    photos = case key
    when "tags"
      Instagram.tag_recent_media value
    when "location"
      Instagram.media_search(*value.split(","))
    else
      []
    end
    
    sample = photos.data.sample
    res.write({ caption: sample.caption, images: sample.images }.to_json) if sample
  end
  
  on "assets" do
    sprockets = Sprockets::Environment.new
    sprockets.append_path "assets/javascripts"
    sprockets.append_path "assets/stylesheets"
    run sprockets
  end
end
