class EntriesController < ApplicationController 
  # profile
  get '/account' do 
    haml :'/entries/entry'
  end 

  post '/register' do
    user = User.create(params) 
    if user.save 
      session[:id] = user.id
      # todo unsure why this needs to be explicitly set unlike entries#login
      @sets = scryfall.sets.paginate(page: params[:page], per_page: 15) 
      redirect :'/sets'
    end 
  end 

  post '/login' do 
    user = User.last(email: params[:email])
    if user.password == params[:password]
      session[:id] = user.id
      if user.has_cards? 
        redirect '/'
      else 
        redirect :'/sets'
      end 
    else 
      redirect :'/users/edit'
    end 
  end

  get '/logout' do 
    session.clear 
    redirect :'/sets'
  end
end