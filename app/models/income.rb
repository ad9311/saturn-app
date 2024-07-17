# == Schema Information
#
# Table name: incomes
#
#  id          :bigint           not null, primary key
#  amount      :decimal(11, 2)   not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  budget_id   :bigint           not null
#
# Indexes
#
#  index_incomes_on_budget_id  (budget_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#
class Income < ApplicationRecord
  belongs_to :budget

  validates :description, presence: true, length: { minimum: 1, maximum: 100 }
  validates :amount, numericality: { greater_than: 0 }

  include TransactionConcern
  include TransactionConcern::Income
  include IncomeSerializer

  after_create :run_after_create
  before_update :run_before_update
  after_update :run_after_update
  before_destroy :run_before_destroy

  private

  def run_after_create
    increment_transaction_count!
    credit_budget!(amount)
    credit_total_income!(amount)
    increment_income_count!
  end

  def run_before_destroy
    decrement_transaction_count!
    debit_budget!(amount)
    debit_total_income!(amount)
    decrement_income_count!
  end

  def run_before_update
    return unless amount_changed?

    debit_budget!(amount_was)
    debit_total_income!(amount_was)
  end

  def run_after_update
    return unless saved_change_to_amount?

    credit_budget!(amount)
    credit_total_income!(amount)
  end
end
