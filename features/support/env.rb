# encoding: utf-8

require 'cucumber/rails'
require 'spork'

ActionController::Base.allow_rescue = false

Spork.prefork do

  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
  # require File.join(File.dirname(__FILE__), 'shared_steps')
  require 'cucumber/rails/world'
  require 'capybara/rails'
  require 'capybara/cucumber'
  require 'capybara/session'
  require 'mime/types'

  Capybara.default_selector = :css
end

Spork.each_run do
  ActionController::Base.allow_rescue = false
  Cucumber::Rails::World.use_transactional_fixtures = true
  if defined?(ActiveRecord::Base)
    begin
      DatabaseCleaner.strategy = :transaction
    rescue NameError
      raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
    end
  end
end