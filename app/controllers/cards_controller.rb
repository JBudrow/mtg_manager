class CardsController < ApplicationController
  # todo 
  # before_filter :set_sets 

  # show 
  get '/sets/:code/card/:number' do 
    @card = scryfall.card_code_number(params[:code], params[:number])
    @reprints = scryfall.reprints(@card['name'])
    @rulings = scryfall.rulings(@card['id'])
    haml :'/cards/show'
  end

  # index 
  get '/cards' do
    unless current_user.has_cards? 
      redirect back, warning: "Woah now, you don't have any cards!"
    else 
      cards = current_user.cards.all.sort_by!(&:updated_on)
      @cards = cards.reverse!
      haml :'/cards/index'
    end 
  end 

  # todo promos/token routes/views can be refactored into one
  get '/promos' do 
    sets = scryfall.sets 
    @promos = sets.select{|set| set['set_type'] == 'promo'}
    @promos = @promos.paginate(page: params[:page], per_page: 15)
    @latest_promos = scryfall.cards(@promos.first['code'])
    haml :'/cards/promos'
  end 

  get '/tokens' do 
    sets = scryfall.sets 
    @tokens = sets.select{|set| set['set_type'] == 'token'}
    # todo catch `cards` if failed, backup use `sorted_cards`
    @latest_tokens = scryfall.cards(@tokens.first['code'])
    haml :'/cards/tokens'
  end 

  # todo increment/decrement counters can be refactored into one
  # ajax/increment
  put '/increment_counter' do 
    card = Card.build(params[:scryfall_id], current_user)

    content_type 'application/json'
    {:quantity_value => card.quantity}.to_json
  end 

  # ajax/decrement
  put '/decrement_counter' do 
    card = current_user.cards.last(params[:scryfall_id]) 
    card.decrease

    content_type 'application/json'
    {:quantity_value => card.quantity}.to_json
  end 

  #ajax/destroy
  delete '/sets/:set/card/:number' do 
    @cards = current_user.cards.last(params[:set], params[:number]) 
    @cards.destroy

    content_type 'application/json'
    {:quantity_value => card.quantity}.to_json
  end 

  # todo before_filter
    # private 
    # def set_sets
    #   @sets = scryfall.sets 
    # end 
end