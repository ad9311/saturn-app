class AddDetailsToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
    end
  end
end
