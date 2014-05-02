class CreateUsers < ActiveRecord::Migration
  def change
  	drop_table :users
  	
    create_table :users do |t|
      t.string :name
      t.string :aka
      t.string :last_login
      t.string :email

      t.timestamps
    end
  end
end