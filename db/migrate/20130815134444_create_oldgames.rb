class CreateOldgames < ActiveRecord::Migration
  def change
    create_table :oldgames do |t|
      t.column :user_id, :integer
      t.column :score, :integer
      t.column :jambgame, :text 
      t.timestamps
    end
  end
end
