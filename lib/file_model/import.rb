module FileModel
  module Import
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Path
      autoload :Dir
    end
  end
end
