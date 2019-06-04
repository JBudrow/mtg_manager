class SetsController < ApplicationController
  # index
  get '/sets' do 
    # @sets = scryfall.sets.paginate(page: params[:page], per_page: 15) 
    # testing
    response = scryfall.sets
    @sets = response.reject! {|k,_| k['card_count'] == 0}
    @sets = @sets.paginate(page: params[:page], per_page: 15)
    # though we are skipping if set['card_count']  == 0 
    # sorted_cards still being called on for the ones skipped?
    haml :'/sets/index'
  end
  
  # show 
  # working
  # get "/sets/:code" do 
  #   @cards = scryfall.cards(params[:code])
  #   haml :'/sets/show'
  # end 

  # show
  # todo testing redis 
  # [4] pry(#<SetsController>)> JSON.parse(redis.get(session["session_id"]))
  # => [{"object"=>"set",
  #   "id"=>"2f5f2509-56db-414d-9a7e-6e312ec3760c",
  #   "code"=>"m19",
  #   "mtgo_code"=>"m19",
  #   "tcgplayer_id"=>2250,
  #   ...
 
  # testing 1/2
  get "/sets/:code" do 
    session_id = session[:session_id]
    redis = Redis.new

    # @cards = scryfall.cards(params[:code])
    # @cards = scryfall.sorted_cards(params[:code])
    # @cards = HTTParty.get("https://api.scryfall.com/cards/search?order=color&q=e%3A#{params[:code]}&unique=prints")
    @cards = scryfall.sorted_cards(params[:code])
    redis.set(session_id, @cards)
    # redis.get(session_id)
    
    haml :'/sets/show'
  end 

  # testing 2/2
  # get "/sets?code=#{:code}" do 
  #   session_id = session[:session_id]
  #   redis = Redis.new 

  #   @cards = scryfall.sorted_cards(params[:code]) 
  #   redis.set(session_id, @cards)
  #   haml :'/sets/show'
  # end 

  # filter
  get "/sets/:code?filter=#{:color}" do 
    color = params[:color]
    @cards = scryfall.filter_color(params[:code], color)
    haml :'/sets/show'
  end  
end 