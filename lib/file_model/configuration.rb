module FileModel
  class Configuration
    attr_accessor :store

    def initialize
      @store = :memory
    end
  end
end
