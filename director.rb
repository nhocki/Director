require 'rubygems'
require 'yaml'
require 'sinatra'
require 'initializers/load_config'
require 'lib/authorization'
require 'lib/models'
require 'lib/helpers'

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

puts "Created by Nicolas Hock -- nhocki@gmail.com"