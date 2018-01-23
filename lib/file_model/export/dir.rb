module FileModel
  module Export
    class Dir
      extend ActiveModel::Callbacks

      define_model_callbacks :each

      attr_reader :options, :export_path, :index

      def initialize(export_path:, processor:, options: {})
        @export_path = export_path
        @options     = options
        @processor   = processor
        @index       = 0
        @registry    = FileModel::Store::Memory.instance

        FileUtils::mkdir_p(export_path)

        nil
      end

      def each(context={})
        return to_enum(__callee__) unless block_given?

        instance = processor.new(options)
        registry.models.each do |name, model|
          run_callbacks :each do
            instance.process(model: model, context: context)
            yield model
            @index += 1
          end
        end
      end

      def total
        registry.models.keys.count
      end

      private

      attr_reader :registry, :processor

    end
  end
end
