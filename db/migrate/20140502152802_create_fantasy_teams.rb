class CreateFantasyTeams < ActiveRecord::Migration
  def change
    create_table :fantasy_teams do |t|
      t.string :tname
      t.integer :user_id

      t.timestamps
    end
    add_index :fantasy_teams, [:user_id, :created_at]
  end
end
