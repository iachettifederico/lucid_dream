require "./plugins/extension_matchers"
require "./plugins/haml_helpers"
require "./plugins/foundation_helpers"
require "./plugins/mystique"
require "fattr"
require "string_plus"

module LucidDream
  class InMemoryRegistry
    def journal_repository
      journals = [
                  Journal.new(name: "My first journal"),
                  Journal.new(name: "two"),
                  Journal.new(name: "three"),
                  Journal.new(name: "four"),
                 ]
      InMemoryJournalRepository.new(journals)
    end

    
  end
  
  def self.registry
    @registry ||= InMemoryRegistry.new
  end
  
  class WebApp < Roda
    plugin :environments
    self.environment = ENV["ENVIRONMENT"]

    plugin :render, engine: "haml"
    plugin :partials
    plugin :view_options

    plugin :json
    plugin :path_matchers
    plugin :empty_root

    require "./assets/assets"

    Dir["./models/*.rb"].each{|f| require f}
    Dir["./repositories/*.rb"].each{|f| require f}

    plugin :extension_matcher

    plugin :haml_helpers
    plugin :foundation_helpers
    
    plugin :mystique
    Dir["./presenters/*.rb"].each{|f| require f}
    
    route do |r|
      r.assets
      r.root do
        view "welcome"
      end

      r.on "journal" do
        journal_repo = LucidDream.registry.journal_repository
        r.root do
          view "journal/journals", locals: {journals: journal_repo.all}
        end

        r.on ":slug" do |slug|
          r.root do
            slug
          end
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
end
