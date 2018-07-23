class Card < ActiveRecord::Base



  def self.murder
    card_types = ['Cat', 'Weapon', 'Room']
    card_types.each do |card_type|
      card = Card.order('RANDOM()').limit(1).where(card_type: card_type)
      card.update({:answer => "t"})
    end
  end

  def self.deal_cards
    players = Player.all.pluck(:id)
    card_count = Card.count.where(answer: 'f')
    x = 1
    until x >= card_count do
      players.each do |player|
        cards = Card.where(answer: 'f', player_id: [nil, ''])
        if cards != nil
          cards.order('RANDOM()').limit(1).update({:player_id => player})
          # cards.each do |card|
          #   card.update({:player_id => player})
          #   break
          # end
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
