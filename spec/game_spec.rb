require 'spec_helper'

describe Game do
  context '.full_reset' do
    it 'will fully reset the game, reset cards, spaces, and players' do
      Card.murder
      Card.deal_cards
      Game.full_reset
      expect(Player.all).to(eq([]))
    end
  end
  context '.parital_reset' do
    it 'will delete everything but players' do
      Card.murder
      Card.deal_cards
      Game.partial_reset
      expect(Player.all).not_to(eq([]))
    end
  end
end
