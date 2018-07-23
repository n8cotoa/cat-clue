class CreateSpacesTable < ActiveRecord::Migration[5.2]
  def change
    create_table(:spaces) do |t|
      t.column(:coordinates, :string)
      t.column(:player_id, :integer)
      t.column(:space_type, :string)
    end
  end
end
