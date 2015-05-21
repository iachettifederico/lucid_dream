require "./plugins/extension_matchers"
require "./plugins/haml_helpers"
require "./plugins/foundation_helpers"
require "./plugins/mystique"
require "fattr"
require "string_plus"

module LucidDream

    
  end
  
  class WebApp < Roda
    plugin :environments
    self.environment = ENV["ENVIRONMENT"]

    plugin :render, engine: "haml"
    plugin :partials
    plugin :view_options

  require "./assets/assets"
  
  Dir["./models/*.rb"].each{|f| require f}
  Dir["./repositories/*.rb"].each{|f| require f}

  plugin :extension_matcher

  plugin :haml_helpers
  plugin :foundation_helpers

  route do |r|
    r.assets
    r.root do
      view "welcome"
    end

    r.on "journal" do
      # Authenticate
      r.root do
        view "journal/journal"
      end
    end

    r.extension("json") do
      r.on "api" do
        r.is "welcome" do
          {
           from: "JSON API",
          }
        end
      end
    end
  end
end
