class RenameBudgetPeriodsYearMonthToUid < ActiveRecord::Migration[7.1]
  def change
    rename_column :budget_periods, :year_month, :uid
  end
end
