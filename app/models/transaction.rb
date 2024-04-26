# == Schema Information
#
# Table name: transactions
#
#  id                      :bigint           not null, primary key
#  amount                  :decimal(11, 2)   not null
#  description             :string           not null
#  transaction_type        :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  budget_period_id        :bigint           not null
#  transaction_category_id :bigint           not null
#
# Indexes
#
#  index_transactions_on_budget_period_id         (budget_period_id)
#  index_transactions_on_transaction_category_id  (transaction_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_period_id => budget_periods.id)
#  fk_rails_...  (transaction_category_id => transaction_categories.id)
#
class Transaction < ApplicationRecord
  belongs_to :budget_period
  belongs_to :transaction_category

  validates :description, presence: true, length: { minimum: 1, maximum: 100 }
  validates :amount, numericality: { greater_than: 0 }

  enum transaction_type: { income: 0, expense: 1 }

  after_create do |record|
    if record.income?
      add_amount_to_budget_period_balance(amount)
    else
      substract_amount_to_budget_period_balance(amount)
    end
  end

  after_update do |record|
    if saved_change_to_amount?
      if record.income?
        add_amount_to_budget_period_balance(amount)
      else
        substract_amount_to_budget_period_balance(amount)
      end
    end
  end

  before_destroy do |record|
    if record.income?
      substract_amount_to_budget_period_balance(amount)
    else
      add_amount_to_budget_period_balance(amount)
    end
  end

  before_update do |record|
    if amount_changed?
      if record.income?
        substract_amount_to_budget_period_balance(amount_was)
      else
        add_amount_to_budget_period_balance(amount_was)
      end
    end
  end

  private

  def add_amount_to_budget_period_balance(new_amount)
    budget_period_balance = budget_period.balance
    budget_period.update(balance: budget_period_balance + new_amount)
  end

  def substract_amount_to_budget_period_balance(new_amount)
    budget_period_balance = budget_period.balance
    budget_period.update(balance: budget_period_balance - new_amount)
  end
end
