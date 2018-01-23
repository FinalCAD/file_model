module FileModel
  module Model
    module Base
      extend ActiveSupport::Concern

      attr_reader :context, :source_path, :index, :previous

      def initialize(path, options={})
        @source_path, @context = path, options[:context]
        @index, @previous      = options[:index], options[:previous].try(:dup) # Let GC clean unlinked previous instance
      end

      def skip?
        false
      end

      class_methods do
        def next(path:, context: {}, previous: nil)
          return if path.end?

          path.read_path
          new(path.current_path, index: path.index, context: context, previous: previous)
        end
      end
    end
  end
end
