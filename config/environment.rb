require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'sinatra/partial'
require 'data_mapper'
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'will_paginate/array'
require 'will_paginate/view_helpers/sinatra'
require 'dm-postgres-adapter'
require 'dm-pg-types'
require 'dm-timestamps'
require 'require_all'

configure :production, :development do 
  DataMapper::Model.raise_on_save_failure = true
end 

configure :production do
  DataMapper.setup(:default, 'postgres://localhost/mtg_manager_production')
end

configure :development do
  DataMapper.setup(:default, 'postgres://localhost/mtg_manager_development')
end

configure :test do
end

require_all 'app'