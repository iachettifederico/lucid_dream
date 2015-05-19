require "./plugins/extension_matchers"
require "./plugins/foundation_helpers"

class LucidDream < Roda
  def page_title
    "Lucid Dream"
  end
  plugin :environments
  self.environment = ENV["ENVIRONMENT"]

  plugin :render, engine: "haml"
  plugin :partials
  plugin :view_options

  plugin :json
  plugin :path_matchers
  plugin :empty_root

  require "./assets/assets"
  plugin :assets, css: css_files, js: js_files
  compile_assets if production?

  Dir["./models/*.rb"].each{|f| require f}
  Dir["./repositories/*.rb"].each{|f| require f}

  plugin :extension_matcher

  plugin :foundation_helpers

  route do |r|
    r.assets
    r.root do
      view "welcome"
    end

    r.on "journal" do
      r.root do
        view "journal/index"
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
