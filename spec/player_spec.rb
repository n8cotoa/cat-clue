require('spec_helper')

describe(Player) do
  context('end of turn') do
    it('will switch turns from the current player to the next player') do
      player1 = Player.create({:turn => false})
      player2 = Player.create({:turn => true})
      player3 = Player.create({:turn => false})
      player2.end_turn
      expect(Player.find(player3.id).turn).to(eq(true))
    end
  end
  context '#roll_dice' do
    it 'will return a number between 1 and 6' do
      player1 = Player.create({:dice_roll => nil})
      player1.roll_dice
      expect(player1.dice_roll).to be_instance_of(Integer)
    end
  end
  
  context '#player_guess_match' do
    it 'will take the players guesses and return a card if unkown to player' do
      Card.murder
      Card.deal_cardsß
      player1 = Player.all.first
      cat_card = Card.where(answer: 'f', card_type: 'Cat').where.not(player_id: player1.id).first
      weapon_card = Card.where(answer: 'f', card_type: 'Weapon').where.not(player_id: player1.id).first
      room_card = Card.where(answer: 'f', card_type: 'Room').where.not(player_id: player1.id).first
      player_guess = [cat_card, weapon_card, room_card]
      player_match = player1.player_guess_match(cat_card, weapon_card, room_card)
      expect(player_guess).to include(player_match)
    end
  end
end
