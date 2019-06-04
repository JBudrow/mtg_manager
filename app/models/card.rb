class Card 
  include DataMapper::Resource

  property :id, Serial

  property :name,             String 
  property :set,              String
  property :set_name,         String
  property :scryfall_id,      String  
  property :oracle_id,        String 
  property :mana_cost,        String
  property :usd_price,        String, default: '0'
  property :usd_foil_price,   String
  property :rarity,           String 
  property :collector_number, String 

  # set, rulings, prints_search, image
  property :uris,          HStore
  # amazon, tcgplayer, magicardmarket, cardhoarder,
  # card_kingdom, mtgo_traders, coolstuffinc
  property :purchase_uris, HStore
  # standard, future, frontier, modern, legacy, pauper,
  # vintage, penny, commander, 1v1, duel, brawl
  property :legalities,    HStore

  property :foil,    Boolean
  property :reprint, Boolean

  property :converted_mana_cost, Integer 
  property :edhrec_rank,         Integer 
  property :quantity,            Integer, default: 0

  property :oracle_text, Text 
 
  # todo is this necessary?
  property :color_identity, Flag[:red, :white, :black, :green, :colorless, :multicolored]

  property :created_on, Date
  property :updated_on, Date

  belongs_to :user, key: true

  def self.build(id=nil, user=nil)
    response = ScryfallApi.new.card_id(id)
    card = first_or_create({scryfall_id: response['id'], user_id: user.id}, {
      name: response['name'],
      set: response['set'],
      set_name: response['set_name'],
      scryfall_id: response['id'],
      oracle_id: response['oracle_id'],
      mana_cost: response['mana_cost'],
      usd_price: response['prices']['usd'],
      usd_foil_price: response['prices']['usd_foil'],
      rarity: response['rarity'],
      collector_number: response['collector_number'],
      foil: response['foil'],
      reprint: response['reprint'], 
      converted_mana_cost: response['cmc'],
      edhrec_rank: response['edhrec_rank'],
      uris: {image_uri: response['image_uris']['normal']}
    })
    # self.increase
    # increase 
    card.increase; card 
  end 

  def increase
    self.update(quantity: self.quantity + 1)
  end 

  def decrease 
    self.update(quantity: self.quantity - 1)
  end 
 
  # todo accounts for (usd only) price and
  # foil if available 
  # def self.price 
  #   if usd_price && usd_foil_price 
      # sum quantity of attr
      # verify if foil and standard are same json (ie id)
  #   elsif 
  # end 
  
  # todo true text gradients
  # def rarity
  # end 
end 