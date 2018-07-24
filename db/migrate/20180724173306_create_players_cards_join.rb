class CreatePlayersCardsJoin < ActiveRecord::Migration[5.2]
  def change
    create_join_table :cards, :players do |t|
      t.index :card_id
      t.index :player_id
    end
  end
end
