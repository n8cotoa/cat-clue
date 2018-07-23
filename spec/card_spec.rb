require 'spec_helper'

context 'murder' do
  it 'grab a random cat card' do
    cat = Card.murder
    Card.reset_cards
    
  end
end
