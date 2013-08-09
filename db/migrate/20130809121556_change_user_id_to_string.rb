class ChangeUserIdToString < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.change :user_id, :string
    end
  end
end
