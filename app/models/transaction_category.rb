# == Schema Information
#
# Table name: transaction_categories
#
#  id         :bigint           not null, primary key
#  color      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_transaction_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class TransactionCategory < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy
  has_many :income_transactions, dependent: :destroy
  has_many :expense_transactions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 25 }
  validates :color, presence: true
end
