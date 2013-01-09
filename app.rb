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

Cuba.use Rack::Session::Cookie, secret: SecureRandom.hex(64)
Cuba.use Rack::Protection
Cuba.use Clogger, format: :Combined, path: "./log/requests.log", reentrant: true
Cuba.plugin Cuba::Render

Cuba.settings[:render][:template_engine] = :slim

Cuba.define do
  on root do
    res.write view("index")
  end
  
  on "assets" do
    sprockets = Sprockets::Environment.new
    sprockets.append_path "assets/javascripts"
    sprockets.append_path "assets/stylesheets"
    run sprockets
  end
end
