module FileModel
  module Processor
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :Prefix
    end
  end
end
