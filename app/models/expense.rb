# == Schema Information
#
# Table name: expenses
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(, )
#  description         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  budget_id           :bigint           not null
#  expense_category_id :bigint           not null
#
# Indexes
#
#  index_expenses_on_budget_id            (budget_id)
#  index_expenses_on_expense_category_id  (expense_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (expense_category_id => expense_categories.id)
#
class Expense < ApplicationRecord
  belongs_to :budget
  belongs_to :expense_category

  validates :description, presence: true, length: { minimum: 1, maximum: 100 }
  validates :amount, numericality: { greater_than: 0 }

  include TransactionConcern
  include TransactionConcern::Expenses
  include ExpenseTransactionSerializer

  after_create :run_after_create
  before_update :run_before_update
  after_update :run_after_update
  before_destroy :run_before_destroy

  private

  def run_after_create
    increment_transaction_count!
    debit_budget!(amount)
    credit_total_expense!(amount)
    increment_expense_count!
  end

  def run_before_destroy
    decrement_transaction_count!
    credit_budget!(amount)
    debit_total_expense!(amount)
    decrement_expense_count!
  end

  def run_before_update
    return unless amount_changed?

    credit_budget!(amount_was)
    debit_total_expense!(amount_was)
  end

  def run_after_update
    return unless saved_change_to_amount?

    debit_budget!(amount)
    credit_total_expense!(amount)
  end
end
