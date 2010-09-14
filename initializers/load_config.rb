configure {@config = YAML.load_file("config/config.yml")}

configure :development do
  @db_file         = @config["development"]["db_filename"]
  @redirect_url    = @config["development"]["redirect_url"]
  @my_domains      = @config["development"]["domains"]
  @admin_user      = @config["development"]["admin_username"]
  @admin_pwd       = @config["development"]["admin_password"]
  @sub_uri         = @config["development"]["sub_uri"]
end

configure :production do
  @db_file         = @config["production"]["db_filename"]
  @redirect_url    = @config["production"]["redirect_url"]
  @my_domains      = @config["production"]["domains"]
  @admin_user      = @config["production"]["admin_username"]
  @admin_pwd       = @config["production"]["admin_password"]
  @sub_uri         = @config["production"]["sub_uri"]
end

set :redirect_url, @redirect_url
set :domains, @my_domains
set :admin_user, @admin_user
set :admin_password, @admin_pwd
set :sub_uri, @sub_uri