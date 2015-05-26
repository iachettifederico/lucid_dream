require "./plugins/extension_matchers"
require "./plugins/haml_helpers"
require "./plugins/foundation_helpers"
require "./plugins/mystique"
require "fattr"
require "string_plus"

module LucidDream
  Dir["./registries/*.rb"].each{|f| require f}

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

    Dir["./repositories/*.rb"].each{|f| require f}
    Dir["./models/*.rb"].each{|f| require f}

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
        journals = [
                    j1 = Journal.new(name: "My first journal"),
                    j2 = Journal.new(name: "two"),
                    j3 = Journal.new(name: "three"),
                    j4 = Journal.new(name: "four"),
                   ]
        entries = [
                    JournalEntry.new(title: "Entry 1", content: "Content for Entry 1", journal: j1),
                    JournalEntry.new(title: "Entry 2", content: "Content for Entry 2", journal: j1),
                    JournalEntry.new(title: "Entry 3", content: "Content for Entry 3", journal: j1),
                    JournalEntry.new(title: "Pepe",    content: "Content for Pepe",    journal: j2),
                    JournalEntry.new(title: "Pepo",    content: "Content for Pepo",    journal: j3),
                    JournalEntry.new(title: "Peter",   content: "Content for Peter",   journal: j4),
                    JournalEntry.new(title: "Parker",  content: "Content for Parker",  journal: j4),
                   ]

        journal_repo = LucidDream.registry.journal_repository(journals: journals)
        journal_entries_repo = LucidDream.registry.journal_entry_repository(entries: entries)
        r.root do
          view "journal/journals", locals: {journals: journal_repo.all}
        end

        r.on ":slug" do |slug|
          r.root do
            view "journal/journal", locals: {journal: journal_repo.find(slug)}
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
