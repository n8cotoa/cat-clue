require 'pry'
class Player < ActiveRecord::Base
  validates :name, uniqueness: true

  def end_turn
    players = Player.all
    last_player = players.last
    if self == last_player
      next_player = players.first
    else
      next_player = players.find(self.id + 1)
    end
    self.update(turn: 'f')
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
    rooms = kitchen + hall + lounge + library + cellar + pool + laboratory + dining + study
    guess_allowed = false ## this will be the return value?
<<<<<<< HEAD
    new_space = Space.find_by(coordinates: new_coords)
=======
    new_space = Space.where(coordinates: new_coords).first
>>>>>>> 442bbc078ba557dded22aa28030434deeeafc58b
    doors = Space.where('space_type LIKE ?', '%Door').all
    original_space = Space.find_by(player_id: self.id)
    original_coords = original_space.coordinates
    available_spaces = self.available_spaces(original_coords)
    roll = self.dice_roll
    if (roll > 0) && (available_spaces.include?(new_space.coordinates))
      if (doors.include?(original_space)) && (rooms.include?(new_space.coordinates)) ## If they're on a door, and new_space is a room, then move them into the room (update new_space), change guess_allowed = true.
        new_space.update(player_id: self.id)
        original_space.update(player_id: nil)
        guess_allowed = true
        roll -= 1
        self.update(dice_roll: roll)
      else ## i.e. new_space is NOT a room
        new_space.update(player_id: self.id)
        original_space.update(player_id: nil)
        roll -= 1
        self.update(dice_roll: roll)

      end
    # else ## i.e. They have no rolls left or they didn't click an adjacent, available space
    end
    guess_allowed
  end

  def available_spaces(current_coords) ## from the current player coords, get the spaces which are adjacent and open (blank space or blank door)
    letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
    player_x_axis = current_coords.split('', 2)[0]
    player_y_axis = current_coords.split('', 2)[1]
    available_spaces = []
    blanks = Space.where(space_type: 'space', player_id: nil)
    doors = Space.where('space_type LIKE ?', '%Door').all
    rooms_and_doors = Space.where.not(space_type: 'space').all
    rooms = rooms_and_doors - doors
    empty = Space.where(player_id: nil).all
    empty_doors = doors & empty
    open_spaces = blanks + empty_doors + rooms
    open_spaces.each do |space|
      space_x_axis = space.coordinates.split('', 2)[0]
      space_y_axis = space.coordinates.split('', 2)[1]
      ## (if on the y axis it's 1 away, and the x-axis is the same) XOR vice versa
      if (((player_y_axis.to_i - space_y_axis.to_i).abs == 1) && (letters.index(player_x_axis) == letters.index(space_x_axis))) ^ (((letters.index(player_x_axis) - letters.index(space_x_axis)).abs == 1) && (player_y_axis.to_i == space_y_axis.to_i))
        available_spaces.push(space.coordinates)
      end
    end
    available_spaces
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
      if cards_to_pick_from.include?(guess)
        returned_card = guess
        break
      else
        returned_card = false
      end
    end
    returned_card
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
