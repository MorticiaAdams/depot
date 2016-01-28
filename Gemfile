source 'https://rubygems.org'

def linux_only(require_as)
    RUBY_PLATFORM.include?('linux') && require_as
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#debug code
#gem 'linecache19-patched'
#gem 'ruby-debug'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Define user roles and authorization
gem 'devise'
gem 'cancan'

# Use Unicorn as the app server
# gem 'unicorn'

# documentation
gem 'annotate'
gem 'rake-notes'
gem 'gem-ctags'
gem 'rails-erd'
gem 'yard'
gem 'guard-yard'
gem 'guard-rspec'
# Paginate the output
gem 'will_paginate'

group :development, :debug, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  #gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'better_errors'
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'capistrano-rails'
  gem 'awesome_print'
  gem 'looksee'
  gem 'hirb'
  gem 'guard-ctags-bundler'
  
  # Control the debugger output
  #gem 'linecache19'
  #replace linecache19 with a patched gem
  #gem 'linecache19-patched'

  # signal to the Linux system
  gem 'rb-inotify',   require: linux_only('rb-inotify')
  gem 'libnotify',    require: linux_only('libnotify')

  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

