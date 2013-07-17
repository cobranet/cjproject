class CreateJabmgames < ActiveRecord::Migration
  def change
    create_table :jabmgames do |t|

      t.timestamps
    end
  end
end
