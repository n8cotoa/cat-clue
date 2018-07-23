class GivePlayersName < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :name, :string
  end
end
