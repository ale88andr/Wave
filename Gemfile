source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem :production do
  gem 'pg'
end

group :assets do
  gem 'haml-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'zurb-foundation'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.12.2'
  gem 'capybara'
  gem 'annotate', '>=2.5.0'
end

group :test do
  gem 'spork', '~> 1.0rc'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails', '4.1.0'
end

gem 'jquery-rails'
gem 'json'

# media
gem 'carrierwave'
gem 'mini_magick', :git => 'git://github.com/minimagick/minimagick.git', :ref => '6d0f8f953112cce6324a524d76c7e126ee14f392'

# auth
gem 'devise'
gem 'cancan'

# paginate
gem 'kaminari'

# web-server
gem 'thin'