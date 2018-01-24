module FileModel
  module Processor
    module Base
      extend ActiveSupport::Concern

      attr_reader :options

      def initialize(options={})
        @options = options
      end

      def skip?(model)
        false
      end

      private

      def run_command(cmd)
        system(cmd)
        nil
      end

      # Private: Internal method for copying files
      #
      # from  - The File, here is expected to receive a File of Tempfile
      # to    - The Pathname where we want to copy the file (Should be a String representing the path)
      #
      # Returns nothing.
      def copy(from, to)
        FileUtils.mkdir_p(File.dirname(to))
        # _to.mkpath # Throw Gem::LoadError (fileutils is not part of the bundle. Add it to your Gemfile.)

        # NOTE: See if a move, or another trick to avoid copy can be done here, for performances matter.
        FileUtils.cp(from.path, to)

        # Clean Tempfile
        from.close  if from.respond_to?(:close) # Can be apply to File as well.
        from.unlink if from.respond_to?(:unlink) # Only for Tempfile

        nil
      end

    end
  end
end
