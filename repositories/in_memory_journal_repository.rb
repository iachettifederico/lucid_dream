module LucidDream
  class InMemoryJournalRepository
    @journals = []

    def self.journals
      @journals
    end
    
    def initialize(journals=[])
      @journals = journals
    end

    def all
      journals
    end

    def find(slug)
      journals.find {|journal| journal.slug == slug}
    end
    
    private
    attr_reader :journals
  end
end
