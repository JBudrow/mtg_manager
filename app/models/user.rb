require 'bcrypt'
class User
  include DataMapper::Resource 
  include BCrypt

  property :id,       Serial 
  property :username, String
  property :email,    String

  property :password, BCryptHash 

  property :created_at, DateTime
  property :updated_at, DateTime

  property :created_on, Date
  property :updated_on, Date

  has n, :cards

  # todo welllllllll really?
  def has_card?(card)
    self.cards.first(scryfall_id: card['id']) ? true : false 
  end 

  def has_cards? 
    self.cards.any?
  end
end 