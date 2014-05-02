class AddIndexToTeamsName < ActiveRecord::Migration
  def change
  	add_index :teams, :tag, unique: true
  	add_index :teams, :name, unique: true
  end
end
