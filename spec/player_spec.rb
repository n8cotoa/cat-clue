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
