# == Schema Information
#
# Table name: expense_categories
#
#  id         :bigint           not null, primary key
#  color      :string           not null
#  default    :boolean          default(FALSE), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_expense_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ExpenseCategory < ApplicationRecord
  belongs_to :user

  has_many :expense_transactions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 25 }
  validates :color, presence: true, length: { is: 7 }
end
