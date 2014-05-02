class CreatePlayers < ActiveRecord::Migration
  drop_table :players;
  def change
    create_table :players do |t|
      t.string :name
      t.string :aka
      t.integer :age
      t.string :location
      t.float :cost

      t.timestamps
    end
  end
end
