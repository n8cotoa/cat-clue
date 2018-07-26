class Card < ActiveRecord::Base
  has_and_belongs_to_many :players
  def self.murder
    card_types = ['Cat', 'Weapon', 'Room']
    card_types.each do |card_type|
      card = Card.order(Arel.sql('RANDOM()')).limit(1).where(card_type: card_type)
      card.update({:answer => "t"})
    end
  end

  def self.deal_cards
    players = Player.all.pluck(:id)
    card_count = Card.where(answer: 'f').count
    x = 1
    until x > card_count do
      players.each do |player|
        cards = Card.where(answer: 'f', player_id: [nil, ''])
        if cards != nil
          cards.order(Arel.sql('RANDOM()')).limit(1).update({:player_id => player})
          x += 1
        else
          x = card_count
        end
      end
    end
  end

  def self.reset_cards
    Card.update({:answer => 'f', :player_id => nil})
  end
end
