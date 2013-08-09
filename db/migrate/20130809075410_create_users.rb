class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :outh_token
      t.datetime :outh_expires_at

      t.timestamps
    end
  end
end
