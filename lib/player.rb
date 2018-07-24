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

  def player_guess_match(cat, weapon, room)
    player_guess = [cat, weapon, room]
    cards_to_pick_from = Card.where(answer: 'f').where.not(player_id: self.id)
    returned_card = nil
    player_guess.shuffle.each do |guess|
      if cards_to_pick_from.include?(guess)
        returned_card = guess
        break
      end
      break
    end
    returned_card
  end

end
