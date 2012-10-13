PassRenderer.configure do |config|
  config[:template] = File.expand_path("../../../lib/json/pass.json.erb", __FILE__)
end