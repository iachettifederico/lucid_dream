class Roda
  module RodaPlugins
    module ExtensionMatchers
      module RequestMethods
        def extension(ext)
          if remaining_path.end_with?(".#{ext}")
            remaining_path.chomp!(".json")
            yield
          end
        end
      end
    end

    register_plugin(:extension_matcher, ExtensionMatchers)
  end
end

class LucidDream < Roda
  plugin :environments
  self.environment = ENV["ENVIRONMENT"]

  plugin :render, engine: "haml"
  plugin :json
  plugin :path_matchers

  require "./assets/assets"
  plugin :assets, css: css_files, js: js_files
  compile_assets if production?

  Dir["./models/*.rb"].each{|f| require f}
  Dir["./repositories/*.rb"].each{|f| require f}

  plugin :extension_matcher

  route do |r|
    r.assets
    r.root do
      view "welcome"
    end

    r.extension("json") do
      r.on "api" do
        # next unless r.remaining_path.chomp!(".json")

        r.is "welcome" do
          {
           from: "JSON API",
          }
        end
      end
    end

    r.is "welcome" do
      "From <b>JSON API</b>"
    end

  end

end
