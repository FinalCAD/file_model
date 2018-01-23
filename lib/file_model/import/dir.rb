module FileModel
  module Import
    class Dir
      extend ActiveModel::Callbacks

      define_model_callbacks :next

      delegate :size, :index, :end?, to: :path

      attr_reader :index
      attr_reader :path
      attr_reader :model
      attr_reader :context
      attr_reader :current_model
      attr_reader :previous_model

      def initialize(source_path:, model: FileModel::Model::File, context: {})
        @path, @model, @context = Path.new(source_path), model, context.to_h.symbolize_keys
        reset
      end

      def reset
        path.reset!
        @index = -1
        @current_model = nil
      end

      def each(context={})
        return to_enum(__callee__) unless block_given?

        while self.next(context)
          next if skip?
          yield current_model
        end
      end

      def next(context={})
        return if end?

        run_callbacks :next do
          context = context.to_h.reverse_merge(self.context)
          @previous_model = current_model
          @current_model  = model.next(path: path, context: context, previous: previous_model)
          @index += 1
          @current_model = @index = nil if end?
        end

        current_model
      end

      private

      def skip?
        !!current_model.try(:skip?)
      end

    end
  end
end
