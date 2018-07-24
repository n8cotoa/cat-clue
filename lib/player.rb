class Player < ActiveRecord::Base

  def end_turn
    players = Player.all
    last_player = players.last
    if self == last_player
      next_player = players.first
    else
      next_player = players.find(self.id + 1)
    end
    self.update({:turn => 'f'})
    next_player.update({:turn => 't'})
  end

  def roll_dice
    roll = rand(6) + 1
    self.update({:dice_roll => roll})
    roll
  end

end
