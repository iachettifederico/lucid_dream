module LucidDream
  class Journal
    fattr(:name)
    fattr(:slug) { name.underscore }
    fattr(:entries => [])

    def initialize(**attributes)
      attributes.each do |k, v|
        public_send k, v
      end
    end

    def to_s
      "#{name}: #{slug}"
    end
  end
end
