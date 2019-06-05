require 'bundler/setup'
Bundler.require()

require 'rubygems'
require './config/environment'
# require './config/puma'

DataMapper.finalize
DataMapper.auto_upgrade!

use Rack::MethodOverride
use UsersController
use EntriesController
use CardsController 
use SetsController
use SearchesController
run ApplicationController 

