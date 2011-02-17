require './director'

path = File.dirname(__FILE__)

puts "Created by Nicolas Hock -- nhocki@gmail.com"

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