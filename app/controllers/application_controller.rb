require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'string'
    helpers Sinatra::RedirectWithFlash
    register Sinatra::Flash
    register WillPaginate::Sinatra
  end

  # root
  get '/' do
    if current_user && current_user.has_cards?
      # todo temporary small images call
      @cards = current_user.cards
      haml :'/cards/index'
    else 
      redirect :'/sets'
    end 
  end 

  # not_found do
  #   title 'Not Found!'
  #   haml :'shared/404'
  # end
end 