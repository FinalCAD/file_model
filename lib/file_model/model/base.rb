module FileModel
  module Model
    module Base
      extend ActiveSupport::Concern

      attr_reader :context, :source_path, :index, :previous, :root_path

      def initialize(path, options={})
        @source_path, @context = Pathname(path), (options[:context] || {})
        @index, @previous      = options[:index], options[:previous].try(:dup) # Let GC clean unlinked previous instance
        @root_path             = Pathname(options[:root_path].to_s) # If given, the directory where the files are
      end

      # Public: If this methode retrun true it will be ignore during the iteration on import 
      #
      # Likely testing File, Extension and so on.
      #
      # Returns Boolean
      def skip?
        false 
      end

      class_methods do
        def next(path:, context: {}, previous: nil)
          path.read_path # Read the line and assign the result to current_path
          return if path.end?

          new(path.current_path, root_path: path.root_path, index: path.index, context: context, previous: previous)
        end
      end
    end
  end
end
