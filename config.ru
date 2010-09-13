require 'rubygems'
require 'sinatra'
# require 'director'

path = File.dirname(__FILE__)

# print "Sinatra app is on #{path}"
# Sinatra::Application.default_options.merge!(
#   :run => false,
#   :env => :production
# )
# 
# log = File.new("#{path}/director.log", "a")
# STDOUT.reopen(log)
# STDERR.reopen(log)

set :environment, :production
set :root, path
set :app_file,    File.join(path, 'director.rb')
disable :run
run Sinatra::Application