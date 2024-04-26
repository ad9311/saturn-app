class CreateBudgetPeriods < ActiveRecord::Migration[7.1]
  def change
    create_table :budget_periods do |t|
      t.references :user, null: false, foreign_key: true
      t.float :balance
      t.integer :month
      t.integer :year
      t.integer :year_month

      t.timestamps
    end

    add_index :budget_periods, :year_month, unique: true
  end
end
