module ApplicationHelper
  def title(value=nil)
    @title = value if value
    @title ? "Controller Demo - #{@title}" : 'Controller Demo'
  end

  def current_user 
    @current_user ||= User.get(session[:id]) if session[:id]
  end

  def date_format(date)
    date.strftime('%m/%d/%Y')
  end 

  # todo /config/initializer question mark
  def scryfall; ScryfallApi.new end;

  # todo make array of different images for variety
  def not_found_image
    scryfall.card_code_number('5dn', 52)['image_uris']['large']
  end 

  # todo make array of different images for variety
  def no_cards_image 
    scryfall.card_code_number('sok', 84)['image_uris']['large']
  end 

  def quantity_counter(card)
    if current_user && current_user.has_card?(card)
      Card.last(user_id: current_user.id, scryfall_id: card['id']).quantity
    else
      0 
    end 
  end

  def has_card_faces?(card) 
    card['card_faces'] ? true : false 
  end
  
  # todo check for card faces
  # this will only grab the first face image
  def card_image(card) 
    image = []
    if has_card_faces?(card) 
      image << card['card_faces'][0]['image_uris']['normal']
      image << card['card_faces'][1]['image_uris']['normal']
    else
      image << card['image_uris']['normal']
    end 
    image
  end

  # todo split cards name if it has two faces
  # ie "Conduit of Storms // Conduit of Emrakul" 
  def reformat_twofaced_names(card)
  end 

  def count_reprints(cards)
    if cards['total_cards'] > 1 
      "(#{cards['data'].count})"
    else 
      '(0)'
    end
  end

  # todo refactor into one, count_reprints
  def count_rulings(card)
    ruling_arr = scryfall.rulings(card['id']) 
    "(#{ruling_arr.length})"
  end 

  def reformat_mana_costs(card)
    if card.is_a?(HTTParty::Response) 
      scryfall_card = scryfall.card_id(card['id'])
      scryfall_card['mana_cost'].gsub(/[{}]/, '{'=>'','}'=>'').downcase.split('')
    else 
      # card.gsub(/[{}]/, '{'=>'','}'=>'').downcase.split('')
      card.mana_cost.gsub(/[{}]/, '{'=>'','}'=>'').downcase.split('') 
    end 
  end 

  # prevent nil exception association on user -> card#quantity
  # will not work under User, can not call method if self is nil
  # possibly under Card class
  def inventory(card)
    unless current_user 
      '0'
    else 
      Card.last(scryfall_id: card['id'], user_id: current_user.id)
    end
  end 

  def legal_label(val)
    case val 
    when 'legal'; 'success'
    when 'not_legal'; 'dark'
    when 'banned'; 'danger'
    end 
  end
  
  ##### todo money module #####
  def has_price?(card)
    if card.is_a?(Hash)
      !card['prices']['usd'].nil?
    else 
      !card.usd_price.nil? 
    end 
  end 

  def remove_dot(string)
    # string.gsub('.','')
    if !string.nil? 
      string.gsub('.','')
    else  
      '0.00'
    end 
  end

  def json_price(card)
    str = card['prices']['usd']
    if str 
      new_str = remove_dot(str)
    else  
      new_str = '0.00'
    end 
    return Money.new(new_str).format 
  end 

  def attr_price(card) 
    str = card.usd_price 
    new_str = remove_dot(str)
    return Money.new(new_str).format 
  end 

  # todo arg to include other currency signs
  def format_price(user, card)
    if current_user && Card.last(user_id: user.id, scryfall_id: card['id'])
      multiply_quantity(user, card)
    else 
      json_price(card)
    end  
  end 

  # todo should be Card class method 
  def multiply_quantity(user, card)
    # todo check statement whether card is json or Card object
    card = Card.last(user_id: user.id, scryfall_id: card['id'])
    price = remove_dot(card.usd_price) 
    product = Money.new(price) * card.quantity
    product.format
  end 

  def multiply_user_quantity(card) 
    price = remove_dot(card.usd_price)
    # call `format`
    Money.new(price) * card.quantity 
  end 

  # def collection_currency
  #   card_prices = []
  #   current_user.cards.each do |card|
  #     next if card.usd_price.nil?
  #     price = reformat(card.usd_price)
  #     if card.quantity > 1 
  #       card_prices << Money.new((price.to_i * card.quantity).to_i)
  #     else 
  #       card_prices << Money.new(price)
  #     end
  #   end
  #   card_prices.inject(:+).format
  # end

  def collection_currency
    card_prices = []
    current_user.cards.each do |card|
      price = remove_dot(card.usd_price)
      card_prices << Money.new(price) * card.quantity 
    end
    # call `format`
    card_prices.inject(:+) 
  end

  def set_currency(set)
    if scryfall.cards(set['code'])
      card_prices = []
      response = scryfall.cards(set['code'])
      response.each do |card|
        next if card['prices']['usd'].nil?
        price = reformat(card['prices']['usd'])
        card_prices << Money.new(price)
      end 
      
      unless card_prices.all?(&:nil?)
        card_prices.inject(:+).format
      else 
        # '•'
        ''
      end 
    else 
      '$0.00'
    end 
  end

  # todo place currency related methods to own helper file
  def reformat(number)
    num_without_decimal = number.gsub('.','') 
    unless num_without_decimal.length == 4
      num_without_decimal = '0' + num_without_decimal 
    end
    num_without_decimal
  end

  # todo 
  # def currency_symbol(card) 
  #   sym = card['prices']
  #   case sym 
  #   when sym['usd']; '$' 
  #   when sym['eur']; '€'
  #   else 
  #     'N/A'
  #   end 
  #   sym
  # end 

  # def currency(card)
  #   # todo hardcoded currency type
  #   response = scryfall.card_code_number(card['set'],card['collector_number'])
  #   price = response['prices']['usd']
  #   if price
  #     reformat(response['prices']['usd'])
  #     Money.new(price).format 
  #   else  
  #     'N/A'
  #   end
  # end 

  # def users_cards_currency(card)
  #   unless card.usd_price.nil? 
  #     price = reformat(card.usd_price)
  #     if card.quantity > 1 then price = (price.to_i * card.quantity).to_i;end 
  #     price = Money.new(price).format
  #   else 
  #     '•'
  #   end
  # end 

  # def indiv_currency(user_id, card)
  #   if current_user 
  #     card = Card.last(user_id: user_id, scryfall_id: card['id'])
  #     unless card.nil? 
  #       if card.quantity > 1 then price = (price.to_i * card.quantity).to_i; end 
  #     else 
  #     "$0.00"
  #     end 
  #   else  
  #     card = 
  # end 


  # todo promo icon 
  # cards#promos and tokens too?
  # def promo_icon(set)
  #   if set['parent_set_code'] 
  #     str = # cut the first char in str ie pdom (p) represents promo 
  #     new_str = # 
  #   else  
  #     # display universal promo icon 
  #   end 
  # end 

  # todo related cards, involvement for tokens IF they have a source
  # def token_source(card)
  # end 

end

ApplicationController.helpers ApplicationHelper