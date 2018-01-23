require 'singleton'

module FileModel
  module Store
    class Memory
      include FileModel::Store::Base
      include Singleton

      attr_reader :models

      def initialize
        reset!
      end

      def append_model(model)
        return unless model.name
        models[model.name] ||= model
      end
      alias_method :<<, :append_model

      def reset!
        @models = {}
      end

      def size
        models.keys.count
      end

    end
  end
end
