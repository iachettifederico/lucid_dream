module LucidDream
  class InMemoryRegistry
    @repositories = {}

    def self.repositories
      @repositories
    end
    
    def journal_repository(**options)
      journals = options[:journals] || []
      self.class.repositories[:journal] ||= InMemoryJournalRepository.new(journals)
    end
    
    def journal_entry_repository(**options)
      entries = options[:entries] || []
      self.class.repositories[:journal_entry] ||= InMemoryJournalEntryRepository.new(entries)
    end
  end
end
