module FileModel
  module Store
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :Memory
    end
  end
end
