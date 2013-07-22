class CreateGames < ActiveRecord::Migration
  def change
    drop_table :games
    create_table :games do |t|
      t.column :jambgame, :text 
      t.column :user_id, :integer
      t.timestamps
    end
  end
end
