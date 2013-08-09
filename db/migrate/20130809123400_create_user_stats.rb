class CreateUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.column :user_id, :string
      t.column :property, :string
      t.column :value, :string
      t.timestamps
    end
    add_index(:user_stats,:user_id)
  end
end
