require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'
load './Rakefile'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.before(:all) do
    run_rake_task('db:drop')
    run_rake_task('db:migrate')
    run_rake_task('db:seed')
  end
  config.after(:all) do
    run_rake_task('db:drop')
  end
end

def run_rake_task(task)
  RAKE_APP[task].invoke
  if task == 'db:migrate' || task == 'db:drop' 
    RAKE_APP[task].reenable
  end
end

include Rack::Test::Methods

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
