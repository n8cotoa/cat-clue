require 'spec_helper'

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
