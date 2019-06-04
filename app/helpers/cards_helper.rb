module CardsHelper 
  def color_type(color)
    case color 
    when 'r'; 'mountain'
    when 'w'; 'plains'
    when 'g'; 'forest'
    when 'b'; 'swamp'
    when 'u'; 'island'
    when 'c'; 'colorless'
    end
  end
end 

CardsController.helpers CardsHelper

