require('pry')

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
hall = ['A5', 'A6', 'B5', 'B6']
lounge = ['A9', 'A10', 'B9', 'B10']
library = ['E1', 'E2', 'F1', 'F2']
cellar = ['E5', 'E6', 'F5', 'F6']
pool = ['E9', 'E10', 'F9', 'F10']
laboratory = ['I1', 'I2', 'J1', 'J2']
dining = ['I5', 'I6', 'J5', 'J6']
study = ['I9', 'I10', 'J9', 'J10']
doors = ['B3', 'C5', 'C10', 'G1', 'E4', 'D9', 'J3', 'H6', 'H10']
rooms = [kitchen, hall, lounge, library, cellar, pool, laboratory, dining, study]
rooms_hash = {0 => 'Kitchen', 1 => 'Hall', 2 => 'Lounge', 3 => 'Library', 4 => 'Cellar', 5 => 'Pool Room', 6 => 'Laboratoy', 7 => 'Dining Room', 8 => 'Study'}
coordinates.each do |coordinate|
  space = Space.create({:coordinates => coordinate, :player_id => nil, :space_type => 'space'})
  rooms.each_with_index do |room, index|
    if room.include?(coordinate)
      space.update({:space_type => rooms_hash[index]})
    end
  end
  if doors.include?(coordinate)
    doors.each_with_index do |door, index|
      if door == coordinate
        space.update(:space_type => rooms_hash[index] + ' Door')
      end
    end
  end
end

#builds cards in database
Card.destroy_all
card_type = ['Cat', 'Weapon', 'Room']
cats_card = ['Miss Scarlet', 'Colonel Mustard', 'Mr. Green', 'Mrs. Peacock', 'Mrs. White', 'Professor Plum']
cats_img = {"Miss Scarlet" => '../img/cat_img/scarlet.png', "Colonel Mustard" => '../img/cat_img/mustard.png', "Mr. Green" => '../img/cat_img/green.png', "Mrs. Peacock" => '../img/cat_img/peacock.png', "Mrs. White" => '../img/cat_img/Mrs_White.png', "Professor Plum" => '../img/cat_img/purple.png'}
weapons_card = ['Strong Catnip', 'Cardboard Box', 'Vase', 'Bread', 'Dog', 'Knife']
rooms_card = ['Laboratory', 'Library', 'Kitchen', 'Dining Room', 'Hall', 'Study', 'Pool Room', 'Lounge']
card_category =[cats_card, weapons_card, rooms_card]

card_category.each_with_index do |cards, index|
  cards.each do |card|
    Card.create({:card_type => card_type[index], :card_name => card, :answer => 'f', :player_id => nil, :image => ''})
  end
end

cats_card.each_with_index do |cat, index|
  Card.create({:card_type => "Cat", :card_name => cat, :answer => 'f', :player_id => nil, :image => cats_img[cat]})
end

#bulds example players
Player.destroy_all #destroys all player info in database
players = ['Player 1', 'Player 2', 'Player 3', 'Player 4']
players.each do |player|
  Player.create({:name => player, :dice_roll => nil, :guess => nil, :turn => 'f'})
  Player.all.first.update({:turn => 't'})
end

#assign players to set spaces
# player1 = Player.find_by(name: 'Player 1')
# player2 = Player.find_by(name: 'Player 2')
# player3 = Player.find_by(name: 'Player 3')
# player4 = Player.find_by(name: 'Player 4')
# player1_start = Space.find_by(coordinates: 'H1')
# player2_start = Space.find_by(coordinates: 'A3')
# player3_start = Space.find_by(coordinates: 'C10')
# player4_start = Space.find_by(coordinates: 'J7')
# player1_start.update(player_id: player1.id)
# player2_start.update(player_id: player2.id)
# player3_start.update(player_id: player3.id)
# player4_start.update(player_id: player4.id)
