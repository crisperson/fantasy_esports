class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :tag
      t.string :website

      t.timestamps
    end
  end
end
