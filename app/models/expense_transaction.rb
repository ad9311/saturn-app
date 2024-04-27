class ExpenseTransaction < ApplicationRecord
  belongs_to :budget_period
  belongs_to :transaction_category
end
