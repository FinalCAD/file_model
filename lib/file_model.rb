require "file_model/version"
require 'active_support/all'
require 'active_model'

require 'file_model/configuration'

module FileModel
  extend ActiveSupport::Autoload

  autoload :Import
  autoload :Model
  autoload :Store
  autoload :Export
  autoload :Processor

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
