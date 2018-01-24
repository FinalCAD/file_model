module FileModel
  module Model
    class File
      include FileModel::Model::Base

      def extension
        source_path.extname
      end

      def name
        source_path.basename(".*")
      end

      def full_name
        source_path.basename
      end

      def dir_path
        Pathname(source_path.to_s.gsub(root_path.to_s,'').gsub(/^\//,'')).dirname
      end

      def file_path
        dir_path + full_name
      end

      def escaped
        Pathname(source_path.to_s.gsub(/ /,'\ '))
      end

      def exploded_path
        @exploded_path ||= source_path.to_s.split(::File::SEPARATOR)
      end

    end
  end
end
