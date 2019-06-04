module SetsHelper 
  # todo this is hot garbage
  def scrollspy_card_color(c)
    arr = c['color_identity'].map(&:downcase)
    if arr.length > 1 
      'multicolored'
    elsif arr.first.nil? 
      'colorless'
    elsif arr.first == 'r'
      'mountains'
    elsif arr.first == 'w'
      'plains' 
    elsif arr.first == 'g'
      'forest'
    elsif arr.first == 'b'
      'swamp' 
    elsif arr.first == 'u'
      'island' 
    end 
  end 

  def nav_type(color)
    case color 
    when 'r'; 'moutains'
    when 'w'; 'plains'
    when 'g'; 'forest'
    when 'b'; 'swamp'
    when 'u'; 'island'
    when 'c'; 'colorless'
    end
  end 
end 

SetsController.helpers SetsHelper