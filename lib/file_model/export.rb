module FileModel
  module Export
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Dir
    end
  end
end
