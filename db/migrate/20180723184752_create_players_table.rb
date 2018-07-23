class CreatePlayersTable < ActiveRecord::Migration[5.2]
  def change
    create_table(:players) do |t|
      t.column(:turn, :boolean)
      t.column(:dice_roll, :integer)
      t.column(:guess, :string)
    end
  end
end
