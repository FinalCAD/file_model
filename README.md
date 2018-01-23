# FileModel

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/file_model`. To experiment with that code, run `bin/console` for an interactive prompt.

Simple library to browse an directory structure and for each file instantiate a model.

[![Maintainability](https://api.codeclimate.com/v1/badges/b555e20a16d6c8776959/maintainability)](https://codeclimate.com/github/FinalCAD/file_model/maintainability)

[![Dependency Status](https://gemnasium.com/FinalCAD/file_model.svg)](https://gemnasium.com/FinalCAD/file_model)

[![Build Status](https://travis-ci.org/FinalCAD/file_model.svg?branch=master)](https://travis-ci.org/FinalCAD/file_model) (Travis CI)

[![Coverage Status](https://coveralls.io/repos/FinalCAD/file_model/badge.svg?branch=master&service=github)](https://coveralls.io/github/FinalCAD/file_model?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'file_model'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install file_model

## Usage

### Load model in memory

To load the models, we need to give an input directory where the original files can be found

`Composer::Import::Dir` browse a directory and for every file instantiate a model.

The instantiated model is quite basic, is safe to override it. Basically, it contains the path of the file and an `skip?` method.

You can override this way to ignore all path that contain the keyword `A Special KeyWork In The Path` for instance.

```
class MyModel
  include FileModel::Model::Base
  def skip?
    source_path.match(/A Special KeyWork In The Path/)
  end
end
```

How use it?

You can instantiate to an instance to read a specific directory like
```
source_path = 'a/whatever/path'
instance    = FileModel::Import::Dir.new(source_path: source_path, model=MyModel, context={})
```

Once you have the Dir instance you can use in both ways :

```
instance_of_my_model_class = instance.next
FileUtils.cp(model.source_path, "/to/whatever/path") unless instance_of_my_model_class.skip?
```

Or

```
instance.each do |model|
  FileUtils.cp(model.source_path, "/to/whatever/path")
end
```

## Configuration

You can change the layout configuration

```
FileModel.configure do |config|
  config.store = :memory
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/file_model. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FileModel project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/file_model/blob/master/CODE_OF_CONDUCT.md).
