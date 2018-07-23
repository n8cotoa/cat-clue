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
end
