source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in file_model.gemspec
gemspec

group :test do
  gem 'mutant-rspec', git: 'https://github.com/mbj/mutant.git'
  gem 'coveralls', require: false
  gem 'pry-byebug'
  gem 'rspec', '3.6.0'
end
