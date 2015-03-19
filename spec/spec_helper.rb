ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'

if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    products = JSON.parse(File.read("db/toys.json"))
    products.each { |p| Product.create(p) }
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.order = 'default'
end

ActiveRecord::Base.logger.level = 2

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app