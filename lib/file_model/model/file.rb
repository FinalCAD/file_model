module FileModel
  module Model
    class File
      include FileModel::Model::Base

      def extension
        ::File.extname(exploded_path.last).gsub(/^\./,'')
      end

      def name
        ::File.basename(exploded_path.last, ".#{extension}")
      end

      def full_name
        exploded_path.last
      end

      def dir_path
        ::File.dirname(source_path.gsub(root_path,'')).gsub(/^\//,'')
      end

      def exploded_path
        @exploded_path ||= source_path.split(::File::SEPARATOR)
      end

    end
  end
end
