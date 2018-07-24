require('spec_helper')

describe(Player) do
  context('#end_turn') do
    it('will switch turns from the current player to the next player') do
      player1 = Player.find_by(name: 'Player1')
      player2 = Player.find_by(name: 'Player2')
      player3 = Player.find_by(name: 'Player3')
      player4 = Player.find_by(name: 'Player4')
      player1.update(turn: 'f')
      player2.update(turn: 'f')
      player3.update(turn: 'f')
      player4.update(turn: 't')
      player4.end_turn
      player1 = Player.find_by(name: 'Player1')
      player4 = Player.find_by(name: 'Player4')
      expect(player1.turn).to(eq(true))
      expect(player4.turn).to(eq(false))
    end
  end
  context '#roll_dice' do
    it 'will return a number between 1 and 6' do
      player1 = Player.create({:dice_roll => nil})
      player1.roll_dice
      expect(player1.dice_roll).to be_between(1,6).inclusive
      player1.roll_dice
      expect(player1.dice_roll).to be_between(1,6).inclusive
      player1.roll_dice
      expect(player1.dice_roll).to be_between(1,6).inclusive
      player1.roll_dice
      expect(player1.dice_roll).to be_between(1,6).inclusive
    end
  end
end
