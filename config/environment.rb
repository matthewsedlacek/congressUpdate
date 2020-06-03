require "bundler/setup"
Bundler.require(:default)
require_all "lib"


ActiveRecord::Base.establish_connection(
    adapter:    'postgresql',
    database:   'crowns',
    username:   'postgres',
    password:   'dmallo33'
  )