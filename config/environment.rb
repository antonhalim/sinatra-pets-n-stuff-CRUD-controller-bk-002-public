ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require 'json'
require 'yaml'
require 'open-uri'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/petstore_#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'

RAKE_APP ||= Rake.application
