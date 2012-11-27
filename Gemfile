source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'
gem 'haml-rails'

gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-facebook'
gem 'active_attr'
gem 'active_decorator'
gem 'omniauth-twitter'
gem 'kaminari'
gem 'rvm-capistrano'
gem 'iso-639'
gem 'exception_notification', :require => 'exception_notifier'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'logaling-command', :git => 'git://github.com/logaling/logaling-command.git', :require => 'logaling'

group :development do
  gem 'i18n_generators'
  gem 'foreman'
  gem 'rails-footnotes'
  gem 'capistrano', :require => nil
  gem 'capistrano-ext', :require => nil
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'faker'
end
