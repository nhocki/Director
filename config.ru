require 'rubygems'
require 'sinatra'

require 'director'

set :environment, :production

run Sinatra.application