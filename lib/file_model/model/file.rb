module FileModel
  module Model
    class File
      include FileModel::Model::Base

      def exploded_path
        @exploded_path ||= source_path.split(::File::SEPARATOR)
      end

    end
  end
end
