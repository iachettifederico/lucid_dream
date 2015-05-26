module LucidDream
  class InMemoryJournalEntryRepository
    def initialize(entries=[])
      @entries = entries
    end

    def all
      @entries
    end

    def find(slug)
      @entries.find {|entry| entry.slug == slug}
    end

    
    def for(journal)
      @entries.select { |entry| entry.journal.slug == journal.slug }
    end

    private
    attr_reader :entries
  end
end
