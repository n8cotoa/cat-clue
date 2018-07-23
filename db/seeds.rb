#Seeds database with spaces and cards

#builds borad game spaces in database
Space.destroy_all
letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
coordinates = []
letters.each do |letter|
  numbers.each do |number|
    coordinates.push(coordinate = letter + number)
  end
end
kitchen = ['A1', 'A2', 'B1', 'B2']
ballroom = ['A5', 'A6', 'B5', 'B6']
conservatory = ['A9', 'A10', 'B9', 'B10']
dining = ['E1', 'E2', 'F1', 'F2']
cellar = ['E5', 'E6', 'F5', 'F6']
library = ['E9', 'E10', 'F9', 'F10']
lounge = ['I1', 'I2', 'J1', 'J2']
hall = ['I5', 'I6', 'J5', 'J6']
study = ['I9', 'I10', 'J9', 'J10']
rooms = [kitchen, ballroom, conservatory, dining, cellar, library, lounge, hall, study]
rooms_hash = {0 => 'Kitchen', 1 => 'Ballroom', 2 => 'Conservatory', 3 => 'Dining Room', 4 => 'Cellar', 5 => 'Library', 6 => 'Lounge', 7 => 'Hall', 8 => 'Study'}
coordinates.each do |coordinate|
  space = Space.create({:coordinates => coordinate, :player_id => nil, :space_type => 'space'})
  rooms.each_with_index do |room, index|
    if room.include?(coordinate)
      space.update({:space_type => rooms_hash[index]})
    end
  end
end

#builds cards in database
Card.destroy_all
card_type = ['Cat', 'Weapon', 'Room']
cats_card = ['cat1', 'cat2', 'cat3', 'cat4', 'cat5', 'cat6']
weapons_card = ['weapon1', 'weapon2', 'weapon3', 'weapon4', 'weapon5', 'weapon6']
rooms_card = ['Kitchen', 'Ballroom', 'Conservatory', 'Dining Room', 'Cellar', 'library', 'Lounge', 'Hall', 'Study']
card_category =[cats_card, weapons_card, rooms_card]

card_category.each_with_index do |cards, index|
  cards.each do |card|
    Card.create({:card_type => card_type[index], :card_name => card, :answer => 'f', :player_id => nil, :image => ''})
  end
end
