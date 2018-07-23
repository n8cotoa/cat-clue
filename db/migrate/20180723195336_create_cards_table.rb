class CreateCardsTable < ActiveRecord::Migration[5.2]
  def change
    create_table(:cards) do |t|
      t.column(:card_type, :string)
      t.column(:card_name, :string)
      t.column(:answer, :boolean)
      t.column(:image, :string)
      t.column(:player_id, :integer)
    end
  end
end
