require 'sinatra/base'
class ScryfallApi
  include HTTParty
  base_uri 'https://api.scryfall.com/'
  format :json 
  
  def sets  
    self.class.get('/sets')['data']
  end

  def set(code)
    self.class.get("/sets/#{code}")
  end

  def cards(code)
    @response = self.class.get(set(code)['search_uri'])
    if @response['has_more']
      @response = @response['data'] + self.class.get(@response['next_page'])['data']
    else 
      @response = @response['data']
    end
    # @response.shuffle!
  end 
  
  def sorted_cards(code)
    # block sorted by color(WUBRGMC)
    # https://api.scryfall.com/cards/search?order=color&q=e%3Am19&unique=prints
    @response = self.class.get("https://api.scryfall.com/cards/search?order=color&q=e%3A#{code}&unique=prints")
    if @response['has_more']
      @response = @response['data'] + self.class.get(@response['next_page'])['data']
    else 
      @response = @response['data'] 
    end 
  end 

  def card_code_number(code, number)
    self.class.get("/cards/#{code}/#{number}")
  end 

  def card_id(id)
    self.class.get("/cards/#{id}")
  end 

  def reprints(name) 
    self.class.get("https://api.scryfall.com/cards/search?q=%2B%2B!%22#{' '+name+' '}%22")
  end 

  def rulings(card)
    self.class.get("/cards/#{card['set']}/#{card['collector_number']}/rulings")['data']
  end

  def filter_color(color, code)
    self.class.get("https://api.scryfall.com/cards/search?q=c%3A#{color}+e%3A#{code}&order=color&as=grid")['data']
  end

  def search(name)
    @response = self.class.get("https://api.scryfall.com/cards/search?q=#{name}")
    if @response['has_more']
      @response = @response['data'] + self.class.get(@response['next_page'])['data']
    else 
      @response = @response['data']
    end 
  end

  # todo reject ie ['type_line' => 'Basic Land - Swamp']
  # regex
  def random
    random_card = self.class.get('/cards/random')
  end
 
  # only return card name, not rest of the json values
  # ux search bar
  # https://api.scryfall.com/cards/autocomplete?q=thal 
  def autocomplete(name)
    self.class.get("/cards/autocomplete?q=#{name}")
  end 

  # fuzzy search in response to self#autocomplete 
  def named(name)
    # do we need to modify the json
    # url_char_name = name.gsub!(' ','+')
    url_char_name = name.gsub(' ','+')
    self.class.get("/cards/named?fuzzy=#{url_char_name}")
  end
  
  # fuzzy search in response to self#autocomplete and add image(s)
  def named_image(name)
    card = named(name)
    return card['image_uris']['normal']
  end 

  def rulings(id)
    self.class.get("/cards/#{id}/rulings")['data']
  end 

  # todo tokens, promos, etc.
  def filtered_sets(type)
    self.class.get(sets).select{|set| set['set_type'] == type}
  end 
end 