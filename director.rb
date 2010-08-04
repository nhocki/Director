require 'rubygems'
require 'yaml'
require 'sinatra'
require 'initializers/load_config'
require 'lib/authorization'
require 'lib/models'
require 'lib/helpers'

get '/backstage/?' do
  require_admin
  @page_title = "Backstage Area"
  @movements = Movement.all(:order => [:created_at.desc])
  erb :index
end

get '/backstage/logout/?' do
  require_admin
  @page_title = "Comeback soon!"
  logout
  redirect '/backstage'
end

get '/backstage/:id/?' do
  require_admin
  @page_title = "Movement Rehearsal ##{params[:id]}"  
  @movement = Movement.get(params[:id])
  erb :show
end

get '/*/?' do
  @movement = Movement.create(
    :referer => check_referer,
    :full_path_info => request.url,
    :path_info => request.fullpath,
    :ours => check_trusted_domain
  )
  #erb "You would be redirected to #{options.redirect_url}"
  redirect "#{options.redirect_url.to_s}/#{@movement.full_path_info}", 301
end