module FileModel
  module Model
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :File
    end
  end
end
