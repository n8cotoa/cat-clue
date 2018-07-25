class Player < ActiveRecord::Base

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

  def move
    all_spaces = Space.all
    moves_left = self.dice_roll
    original_space = Space.find_by(player_id: self.id)
    original_space.update(player_id: nil)
    current_coords = original_space.coordinates
    # if moves_left < dice_roll ## should dice_roll decrease after every click or should moves_left?
    # if moves_left < dice_roll
      # allow player to click one away (no diagonally)
      # if they move
        # increase moves_left
      # end
      # if they move onto a door space, they have the option to click on the room to enter it.
        # then they can guess (change view to guess form)
        ###
        # click on space
        ## player image overlays the grid square
    #
  end

  def available_spaces(current_coords) ## from the current player coords, get the spaces which are adjacent and open (blank space or blank door)
    letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
    player_x_axis = current_coords.split('', 2)[0]
    player_y_axis = current_coords.split('', 2)[1]
    available_spaces = []
    blanks = Space.where(space_type: 'space', player_id: nil)
    doors = Space.where('space_type LIKE ?', '%Door').all
    empty = Space.where(player_id: nil).all
    empty_doors = doors & empty
    open_spaces = blanks + empty_doors
    open_spaces.each do |space|
      space_x_axis = space.coordinates.split('', 2)[0]
      space_y_axis = space.coordinates.split('', 2)[1]
      ## (if on the y axis it's 1 away, and the x-axis is the same) XOR vice versa
      if (((player_y_axis.to_i - space_y_axis.to_i).abs == 1) && (letters.index(player_x_axis) == letters.index(space_x_axis))) ^ (((letters.index(player_x_axis) - letters.index(space_x_axis)).abs == 1) && (player_y_axis.to_i == space_y_axis.to_i))
        available_spaces.push(space)
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

end
