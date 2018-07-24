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
    # if moves_left < dice_roll
      # allow player to click one away (no diagonally)
      # if they move
        # increase moves_left
      # end
      # if they move onto a door space, they have the option to click on the room to enter it.
        # then they can guess (change view to guess form)
    #
  end

end
