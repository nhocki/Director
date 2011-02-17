$LOAD_PATH.unshift File.expand_path('../initializers', __FILE__)
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'rubygems'
require 'yaml'
require 'sinatra'
require 'load_config'
require 'authorization'
require 'models'
require 'helpers'

# Goes to the admin panel
get '/backstage/?' do
  require_admin
  @page_title = "Backstage Area"
  @movements = Movement.all(:order => [:created_at.desc])
  erb :index
end

# Destroy the loggin session
get '/backstage/logout/?' do
  require_admin
  @page_title = "Comeback soon!"
  logout
  redirect '/backstage'
end

# Gets a movement report
get '/backstage/:id/?' do
  require_admin
  @page_title = "Movement Rehearsal ##{params[:id]}"  
  @movement = Movement.get(params[:id])
  erb :show
end

get '/favicon.ico' do
  # ignore this?
end

# Gets everything and redirects it to where it should be
get '/*/?' do
  @movement = Movement.create(
    :referer => check_referer,
    :full_path_info => request.url,
    :path_info => request.fullpath,
    :ours => check_trusted_domain
  )
  puts "You will be redirected to #{options.redirect_url.to_s}/#{@movement.path_info} with a 301 Header"
  redirect "#{options.redirect_url.to_s}/#{@movement.path_info}", 301
end