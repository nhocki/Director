require 'rubygems'
require 'sinatra'
require 'director'

path = File.dirname(__FILE__)

print "Sinatra app is on #{path}"
# Sinatra::Application.default_options.merge!(
#   :run => false,
#   :env => :production,
#   :public => path + '/public',
#   :views => path  + '/views'
# )

log = File.new("#{path}/log/director.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

set :environment, :production
set :root, path
set :app_file, File.join(path, 'director.rb')
set :public, path + '/public'
set :views, path + '/views'
disable :run
run Sinatra::Application