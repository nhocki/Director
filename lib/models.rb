require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require 'dm-aggregates'

#DB File is loaded at initializers/load_config.rb
configure { DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/db/#{@db_file}") }

class Movement
  include DataMapper::Resource
  property :id, Serial
  property :referer, String, :length => 255         # A blank referer means the user typed the URL
  property :full_path_info, String, :length => 255  #(request.url) The url requested that have been moved
  property :path_info, String, :length => 255       #(request.full_path) The url requested that have been moved
  property :ours, Boolean, :default => false        # Is it comming from one of your applications?
  property :created_at, DateTime
end

configure :development do
  DataMapper.auto_upgrade!
end

