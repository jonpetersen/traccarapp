# base
require 'bundler/setup'

# gems
require 'logger'
require 'json'
require 'haml'
require 'digest'
require 'date'
require 'time'
require 'yaml'
require 'mysql2'
require 'active_record'
require 'net/http'

require 'sinatra/base'

# configs
require_relative 'deploy_setting'
require_relative 'active_record_setting'

$root_path = File.join(File.dirname(__FILE__), '..')

['helpers', 'extlibs', 'models', 'routes'].each do |dir_name|
  dir_path = File.join($root_path, dir_name, '*.rb')
  Dir.glob(dir_path).each do |file|
    require file
  end
end

class Sinatra::Base
  # helpers
  include DebugOn

  # set sinatra's variables
  set :app_name, "Traccarapp" 
  set :app_logger, Logger.new(File.join($root_path, 'log', "traccarapp.log"), 'daily')
  set :root, $root_path
  set :environment, DeploySetting.environment

  if settings.environment == :production
    enable  :sessions, :logging, :dump_errors
    disable :run, :reload, :show_exceptions
    # set :redis, Redis.new(:db => 2)
  else
    enable  :sessions, :logging, :dump_errors, :show_exceptions, :reload
    disable :run
    # set :redis, Redis.new(:db => 15)
  end

end
