module LucidDream
  class Journal
    fattr(:name)
    fattr(:slug) { name.underscore }
    fattr(:entry_repository,) { LucidDream.registry.journal_entry_repository }
    fattr(:entries) { entry_repository.for(self) }
    
    def initialize(**attributes)
      attributes.each do |k, v|
        public_send k, v
      end
    end

    def to_s
      name
    end

  end
end
