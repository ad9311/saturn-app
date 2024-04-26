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
end
