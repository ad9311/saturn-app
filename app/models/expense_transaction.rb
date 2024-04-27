# == Schema Information
#
# Table name: expense_transactions
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(, )
#  description         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  budget_period_id    :bigint           not null
#  expense_category_id :bigint           not null
#
# Indexes
#
#  index_expense_transactions_on_budget_period_id     (budget_period_id)
#  index_expense_transactions_on_expense_category_id  (expense_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_period_id => budget_periods.id)
#  fk_rails_...  (expense_category_id => expense_categories.id)
#
class ExpenseTransaction < ApplicationRecord
  belongs_to :budget_period
  belongs_to :expense_category

  validates :description, presence: true, length: { minimum: 1, maximum: 100 }
  validates :amount, numericality: { greater_than: 0 }

  include Transactions
  include Transactions::Expenses

  after_create :run_after_create
  before_update :run_before_update
  after_update :run_after_update
  before_destroy :run_before_destroy

  private

  def run_after_create
    increment_transaction_count!
    debit_budget_period!(amount)
    credit_total_expense!(amount)
    increment_expense_count!
  end

  def run_before_destroy
    decrement_transaction_count!
    credit_budget_period!(amount)
    credit_total_expense!(amount)
    decrement_expense_count!
  end

  def run_before_update
    return unless amount_changed?

    credit_budget_period!(amount_was)
    debit_total_expense!(amount_was)
  end

  def run_after_update
    return unless saved_change_to_amount?

    debit_budget_period!(amount)
    credit_total_expense!(amount)
  end
end
