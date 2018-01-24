module FileModel
  module Model
    module Base
      extend ActiveSupport::Concern

      attr_reader :context, :source_path, :index, :previous, :root_path

      def initialize(path, options={})
        @source_path, @context = Pathname(path), options[:context]
        @index, @previous      = options[:index], options[:previous].try(:dup) # Let GC clean unlinked previous instance
        @root_path             = Pathname(options[:root_path].to_s) # If given, the directory where the files are
      end

      def skip?
        false
      end

      class_methods do
        def next(path:, context: {}, previous: nil)
          return if path.end?

          path.read_path # Read the line and assign the result to current_path
          new(path.current_path, root_path: path.root_path, index: path.index, context: context, previous: previous)
        end
      end
    end
  end
end
