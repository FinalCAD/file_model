# Public: Import files
#
# source_path - The Path where to browse the files (Directory)
# model       - The Model Class, every file will intantiate a this model
# options     - The Hash of options accessible for all the import
#
module FileModel
  module Import
    class Dir
      extend ActiveModel::Callbacks

      define_model_callbacks :next

      delegate :size, :index, :end?, to: :path

      attr_reader :index
      attr_reader :path
      attr_reader :model
      attr_reader :options
      attr_reader :current_model
      attr_reader :previous_model

      def initialize(source_path:, model: FileModel::Model::File, options: {})
        @path, @model, @options = Path.new(source_path), model, options.to_h.symbolize_keys
        reset
      end

      def reset
        path.reset!
        @index = -1
        @current_model = nil
      end

      # Public: Iterate on evey files and intantiate a model from it
      #
      # context - The Hash of the options for each model
      #
      # This method implement `ActiveModel::Callbacks` you can use on the caller `<after|before|around>_next :<method_name>` to track any progress
      #
      # Examples
      #
      #   dir_instance.each do |model|
      #     # Doing something with the model
      #   end
      #   # => nothing
      #
      # Returns nothing.
      def each(context={})
        return to_enum(__callee__) unless block_given?

        while self.next(context)
          next if skip?
          yield current_model
        end

        nil
      end

      # Public: Iterate on evey files, one by one, and intantiate a model from it
      #
      # context - The Hash of the options for each model
      #
      # This method implement `ActiveModel::Callbacks` you can use on the caller `<after|before|around>_next :<method_name>` to track any progress
      #
      # Examples
      #
      #   model = dir_instance.next
      #   # => Doing something with the model
      #
      # Returns current instantiated model.
      def next(context={})
        return if end?

        run_callbacks :next do
          context = context.to_h.reverse_merge(self.options)
          @previous_model = current_model
          @current_model  = model.next(path: path, context: context, previous: previous_model)
          @index += 1
          @current_model = @index = nil if end?
        end

        current_model
      end

      private

      # Public: Skip the model if the `skip?` method is implemented
      #
      # Try on the current model if `skip?` method return true, in this case it will be ignore on the `each` method and the import won't iterate on it.
      #
      # Returns boolean
      def skip?
        !!current_model.try(:skip?)
      end

    end
  end
end
