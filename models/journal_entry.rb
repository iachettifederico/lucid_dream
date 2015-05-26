module LucidDream
  class JournalEntry
    
    fattr(:title)
    fattr(:content)
    fattr(:slug) { title.underscore }
    fattr(:journal)
    
    def initialize(**attributes)
      attributes.each do |k, v|
        public_send k, v
      end
    end

    def to_s
      title
    end

  end
end
