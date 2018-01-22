require "file_model/version"
require 'active_support/all'
require 'active_model'

module FileModel
  extend ActiveSupport::Autoload

  autoload :Import
  autoload :Model
  autoload :Store
end
