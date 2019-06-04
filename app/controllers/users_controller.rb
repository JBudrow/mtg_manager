class UsersController < ApplicationController
  # edit 
  get '/profile' do
    if current_user
      haml :'/users/edit' 
    else
      redirect '/profile'
    end 
  end 

  # update 
  post '/profile' do 
    current_user.update(params)
    redirect '/'
  end 
end 