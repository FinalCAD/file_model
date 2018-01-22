lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "file_model/version"

Gem::Specification.new do |spec|
  spec.name          = "file_model"
  spec.version       = FileModel::VERSION
  spec.authors       = ["Joel AZEMAR"]
  spec.email         = ["joel.azemar@gmail.com"]

  spec.summary       = %q{Simple library to browse an directory structure}
  spec.description   = %q{Simple library to browse an directory structure}
  spec.homepage      = "https://github.com/FinalCAD/file_model"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",       "~> 1.16"
  spec.add_development_dependency "rake",          "~> 10.0"
  spec.add_development_dependency "rspec",         "~> 3.0"
  spec.add_development_dependency "activesupport", "~> 4.2"
end
