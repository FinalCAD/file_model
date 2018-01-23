module FileModel
  module Processor
    class Prefix
      include FileModel::Processor::Base

      def skip?(model)
        ::File.directory?(model.source_path)
      end

      def process(model:, context: {})
        return if skip?(model)

        copy(
          compose_path([ model.source_path ]),
          compose_path([ context[:export_path], model.dir_path, 'prefix', model.full_name])
        )
      end

      private

      def compose_path(array)
        OpenStruct.new(path: array.join(::File::SEPARATOR))
      end

    end
  end
end
