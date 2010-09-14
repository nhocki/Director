desc "Install gems that this app depends on. Maybe you'll need to use sudo"

task :install_dependencies do
  dependencies = {
    "sinatra"             => "1.0",
    "dm-core"             => "1.0.0",
    "dm-timestamps"       => "1.0.0",
    "dm-migrations"       => "1.0.0",
    "dm-aggregates"       => "1.0.0",
    "do_sqlite3"          => "0.10.2",
    "dm-sqlite-adapter"   => "1.0.0",
    "ya2yaml"             => "0.29.2"
  }
  
  
  dependencies.each do |gem_name, version|
    puts "Installing #{gem_name} version #{version}"
    system "gem install #{gem_name} --version #{version} --no-ri --no-rdoc"
  end
end

namespace :db do
  desc "Migrate the database"
  task :migrate do
    require 'rubygems'
    require 'dm-core'
    require 'dm-timestamps'
    require 'dm-migrations'
    require 'dm-aggregates'
    require 'sinatra'
    set :environment, :production
    configure :production do
      DataMapper.auto_upgrade!
    end
  end
end