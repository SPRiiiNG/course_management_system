source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#core
gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'
gem 'devise'
gem 'iconv'
gem 'json'

#assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 2.5'
gem "font-awesome-rails"
gem 'bootstrap-sass', '~> 3.3.6'
gem 'angularjs-rails'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'

# Database
gem 'mongoid'
# gem 'mongoid-grid_fs', git: 'https://github.com/ahoward/mongoid-grid_fs'

group :development, :test do
  #generate fake data
  gem 'faker'

  # unit spec
  gem 'rails-controller-testing'
  gem 'mongoid-rspec', :git => 'https://github.com/chocoken517/mongoid-rspec.git'
  gem 'shoulda-matchers', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails'

  # unit spec
  gem 'rails-controller-testing'
  gem 'mongoid-rspec', :git => 'https://github.com/chocoken517/mongoid-rspec.git'
  gem 'shoulda-matchers', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails'

  # helper
  gem 'listen', '~> 3.0.5'
  gem 'database_cleaner', :git => 'https://github.com/DatabaseCleaner/database_cleaner.git'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug' # debugger
  gem 'web-console'
  gem 'parallel_tests' # parallel run test
  gem 'better_errors' # debug console view
  gem "binding_of_caller"
  gem "foreman"
  gem 'simplecov', :require => false

end

group :ubuntu do
  gem 'therubyracer'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
