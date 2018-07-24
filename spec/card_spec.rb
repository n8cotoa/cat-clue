require 'spec_helper'

describe Card do
  context 'murder' do
    it 'grab a random cards and build the murder' do
      card = Card.murder
      expect(Card.where(answer: 't').count).to(eq(3))
    end
  end

  context '.deal_cards' do
    it 'will randomly deal out cards to players' do
      Card.deal_cards
      expect(Card.all.each { |card| card.player_id }).not_to(eql(nil))
    end
  end
  context '.reset_cards' do
    it 'will reset cards removing player_id' do
      Card.deal_cards
      Card.reset_cards
      Card.all.each do |card| #This might not be best practice, ask Franz tomorrow
        expect(card.player_id).to(eql(nil))
      end
    end
    it 'will reset cards and change answer status to false' do
      Card.murder
      Card.reset_cards
      expect(Card.all.each { |card| card.answer }).not_to(include(true))
    end
  end
end
