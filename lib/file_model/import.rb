module FileModel
  module Import
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Path
    end
  end
end
