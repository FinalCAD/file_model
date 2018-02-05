module FileModel
  module Processor
    class Prefix
      include FileModel::Processor::Base

      def skip?(model)
        ::File.directory?(model.source_path)
      end

      def process(model:, context: {})
        return if skip?(model)
        context = options.merge(context)

        copy(
          OpenStruct.new(path: model.source_path.to_s), # Fake a Tempfile
          compose_path(model: model, context: context)
        )
      end

      private

      # Returns an Pathname
      def compose_path(model:, context:)
        (export_path || context[:export_path]) + model.dir_path + Pathname('PREFIX') + model.full_name
      end

    end
  end
end
