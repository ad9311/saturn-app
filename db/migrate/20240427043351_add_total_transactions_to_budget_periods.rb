class AddTotalTransactionsToBudgetPeriods < ActiveRecord::Migration[7.1]
  def change
    change_table :budget_periods, bulk: true do |t|
      t.decimal :total_income, precision: 11, scale: 2, default: 0.0, null: false
      t.decimal :total_expenses, precision: 11, scale: 2, default: 0.0, null: false
    end
  end
end
