# Public: Export files
#
# export_path - The Path where to expore files (Directory)
# processor   - The Processor Class, every model will pass through
# options     - The Hash of options acccessible for all the export
#
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
        @store    = FileModel::Store::Memory.instance

        FileUtils::mkdir_p(export_path)

        nil
      end

      # Public: Iterate on evey model and apply the Processor on it
      #
      # context - The Hash of options for each model
      #
      # This method implement `ActiveModel::Callbacks` you can use on the caller `after_each :<method_name>` to track any progress
      #
      # Examples
      #
      #   dir_instance.each do |model|
      #     Here the model is retuned but the Processor doesn't return anything, it's only if you need to do an extra job after the model was processed.
      #     puts("File: #{model.source_path} Successfully treated")
      #   end
      #   # => nothing
      #
      # Returns nothing.
      def each(context={})
        return to_enum(__callee__) unless block_given?

        instance = processor.new(options)
        store.models.each do |name, model|
          run_callbacks :each do
            next if instance.skip?(model)
            instance.process(model: model, context: context.reverse_merge(options).reverse_merge(export_path: export_path))
            yield model
            @index += 1
          end
        end

        nil
      end

      delegate :size, to: :store

      private

      attr_reader :store, :processor

    end
  end
end
