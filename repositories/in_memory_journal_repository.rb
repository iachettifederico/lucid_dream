module LucidDream
  class InMemoryJournalRepository
    def initialize(journals=[])
      @journals = journals
    end

    def all
      @journals
    end
    
    private
    attr_reader :journals
  end
end
