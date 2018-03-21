module SharedTimecop::Store
  class RailsCache
    DEFAULT_NAME = name.dup.freeze

    attr_reader :name, :read_options, :write_options, :delete_options

    def initialize(name: nil, read_options: nil, write_options: nil, delete_options: nil)
      @name = name || DEFAULT_NAME
      @read_options = read_options
      @write_options = write_options
      @delete_options = delete_options
    end

    def read
      Rails.cache.read(name, read_options)
    end

    def write(stack_item)
      Rails.cache.write(name, stack_item, write_options)
    end

    def clear
      Rails.cache.delete(name, delete_options)
    end
  end

  register :rails_cache, RailsCache
end
