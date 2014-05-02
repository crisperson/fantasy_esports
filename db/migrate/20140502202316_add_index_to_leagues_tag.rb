class AddIndexToLeaguesTag < ActiveRecord::Migration
  def change
    add_index :leagues, :tag, unique: true
    add_index :leagues, :name, unique: true
  end
end
