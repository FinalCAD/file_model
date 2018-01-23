module FileModel
  module Processor
    module Base
      extend ActiveSupport::Concern

      attr_reader :options

      def initialize(options={})
        @options = options
      end

      private

      def run_command(cmd)
        system(cmd)
        nil
      end

      def copy(from, to)
        FileUtils.mkdir_p(File.dirname(to.path.to_s))
        FileUtils.cp(from.path.to_s, to.path.to_s)
        from.close  if from.respond_to?(:close)
        from.unlink if from.respond_to?(:unlink)
        nil
      end

    end
  end
end
