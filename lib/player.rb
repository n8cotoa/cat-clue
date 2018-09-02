require 'pry'
class Player < ActiveRecord::Base
  has_and_belongs_to_many :cards
  validates :name, uniqueness: true

  def end_turn
    players = Player.all
    last_player = players.last
    if self == last_player
      next_player = players.first
    # elsif players.find(self.id + 1) == nil
    # next_player = players.find(self.id + 2)
    else
      next_player = Player.where("id > ?", self.id).first
      # players.find(self.id + 1)
    end
    self.update(turn: 'f', dice_roll: -1)
    next_player.update(turn: 't')
  end

  def roll_dice
    roll = rand(6) + 1
    self.update({:dice_roll => roll})
    roll
  end

  def move(new_coords)
    kitchen = ['A1', 'A2', 'B1', 'B2']
    hall = ['A5', 'A6', 'B5', 'B6']
    lounge = ['A9', 'A10', 'B9', 'B10']
    library = ['E1', 'E2', 'F1', 'F2']
    cellar = ['E5', 'E6', 'F5', 'F6']
    pool = ['E9', 'E10', 'F9', 'F10']
    laboratory = ['I1', 'I2', 'J1', 'J2']
    dining = ['I5', 'I6', 'J5', 'J6']
    study = ['I9', 'I10', 'J9', 'J10']
    all_room_coords = kitchen + hall + lounge + library + cellar + pool + laboratory + dining + study
    roll = self.dice_roll
    original_space = Space.find_by(player_id: self.id)
    original_coords = original_space.coordinates
    available_spaces = self.available_spaces(original_coords)
    new_space = Space.find_by(coordinates: new_coords)
    if !roll.nil? && roll > 0
        if available_spaces.include?(new_space.coordinates)
          new_space.update(player_id: self.id)
          original_space.update(player_id: nil)
          roll -= 1
          self.update(dice_roll: roll)
        end
        if all_room_coords.include?(new_coords)
          guess_allowed = true
        end
    end
  end

  def available_spaces(current_coords)
    ## Setup
    letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
    kitchen = ['A1', 'A2', 'B1', 'B2']
    hall = ['A5', 'A6', 'B5', 'B6']
    lounge = ['A9', 'A10', 'B9', 'B10']
    library = ['E1', 'E2', 'F1', 'F2']
    cellar = ['E5', 'E6', 'F5', 'F6']
    pool = ['E9', 'E10', 'F9', 'F10']
    laboratory = ['I1', 'I2', 'J1', 'J2']
    dining = ['I5', 'I6', 'J5', 'J6']
    study = ['I9', 'I10', 'J9', 'J10']
    rooms_hash = {0 => 'Kitchen', 1 => 'Hall', 2 => 'Lounge', 3 => 'Library', 4 => 'Cellar', 5 => 'Pool Room', 6 => 'Laboratoy', 7 => 'Dining Room', 8 => 'Study'}
    rooms = [kitchen, hall, lounge, library, cellar, pool, laboratory, dining, study]
    doors = Space.where('space_type LIKE ?', '%Door').all
    all_room_coords = kitchen + hall + lounge + library + cellar + pool + laboratory + dining + study
    all_room_spaces = []
    all_room_coords.each do |coords|
      room_space = Space.find_by(coordinates: coords)
      all_room_spaces.push(room_space)
    end
    empty_spaces = Space.where(player_id: nil).all
    empty_room_spaces = all_room_spaces & empty_spaces
    current_space = Space.find_by(coordinates: current_coords)
    player_x_axis = current_coords.split('', 2)[0]
    player_y_axis = current_coords.split('', 2)[1]
    available_spaces = []
    available_coords = []
    empty_halls = Space.where(space_type: 'space', player_id: nil)
    doors = Space.where('space_type LIKE ?', '%Door').all
    empty_doors = doors & empty_spaces
    empty_room_spaces = []
    rooms.each do |room|
      room.each do |room_coords|
        room_space = Space.find_by(coordinates: room_coords)
        if room_space.player_id == nil
          empty_room_spaces.push(room_space)
        end
      end
    end
    ## Check which type of space current_coords is with if statement
    if current_space.space_type == 'space'
      available_spaces = empty_halls + empty_doors
      available_spaces.each do |space|
        space_x_axis = space.coordinates.split('', 2)[0]
        space_y_axis = space.coordinates.split('', 2)[1]
        ## (if on the y axis it's 1 away, and the x-axis is the same) XOR vice versa
        if (((player_y_axis.to_i - space_y_axis.to_i).abs == 1) && (letters.index(player_x_axis) == letters.index(space_x_axis))) ^ (((letters.index(player_x_axis) - letters.index(space_x_axis)).abs == 1) && (player_y_axis.to_i == space_y_axis.to_i))
          available_coords.push(space.coordinates)
        end
      end
    elsif doors.include?(current_space)
      available_spaces = empty_halls + empty_room_spaces
      available_spaces.each do |space|
        space_x_axis = space.coordinates.split('', 2)[0]
        space_y_axis = space.coordinates.split('', 2)[1]
        if (((player_y_axis.to_i - space_y_axis.to_i).abs == 1) && (letters.index(player_x_axis) == letters.index(space_x_axis))) ^ (((letters.index(player_x_axis) - letters.index(space_x_axis)).abs == 1) && (player_y_axis.to_i == space_y_axis.to_i))
          available_coords.push(space.coordinates)
        end
      end
    elsif all_room_spaces.include?(current_space) # Lastly, if you're on a room,
      available_spaces = empty_room_spaces + doors
      available_spaces.each do |space|
        space_x_axis = space.coordinates.split('', 2)[0]
        space_y_axis = space.coordinates.split('', 2)[1]
        if (((player_y_axis.to_i - space_y_axis.to_i).abs == 1) && (letters.index(player_x_axis) == letters.index(space_x_axis))) ^ (((letters.index(player_x_axis) - letters.index(space_x_axis)).abs == 1) && (player_y_axis.to_i == space_y_axis.to_i))
          available_coords.push(space.coordinates)
        end
      end
    end
    available_coords
  end

  def save_guess(cat, weapon, room)
    cat_id = cat.id
    weapon_id = weapon.id
    room_id = room.id
    Player.where(id: self.id).update({:guess => [cat_id, weapon_id, room_id] })
  end

  def player_guess_match(cat, weapon, room)
    player_guess = [cat, weapon, room]
    cards_to_pick_from = Card.where(answer: 'f').where.not(player_id: self.id)
    returned_card = nil

    player_guess.shuffle.each do |guess|
      guess_card = Card.find_by(card_name: guess)
      if cards_to_pick_from.include?(guess_card)
        returned_card = guess
        returned_card
        break
      else
        returned_card = false
      end
    end
    returned_card
  end

  def final_guess(cat, weapon, room)
    murder_scene = Card.where(answer: 't').all
    cat_card = Card.find_by(card_name: cat)
    weapon_card = Card.find_by(card_name: weapon)
    room_card = Card.find_by(card_name: room)
    if murder_scene.include?(cat_card) && murder_scene.include?(weapon_card) && murder_scene.include?(room_card)
      true
    else
      false
    end
  end

  def self.place_player
    start_positions = ['H1', 'A3', 'D10', 'J7']
    index = 0
    Player.all.each do |player|
      Space.where(coordinates: start_positions[index]).update(:player_id => player.id)
      index += 1
    end
  end

end
