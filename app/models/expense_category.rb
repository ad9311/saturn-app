# == Schema Information
#
# Table name: expense_categories
#
#  id         :bigint           not null, primary key
#  color      :string           not null
#  default    :boolean          default(FALSE), not null
#  deletable  :boolean          default(TRUE), not null
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

  has_many :expense_transactions, dependent: :nullify

  validates :name, presence: true, length: { minimum: 1, maximum: 25 }
  validates :color, presence: true, length: { is: 7 }

  before_destroy :transfer_expenses_to_default, prepend: true
  before_destroy :prevent_default_category_deletion, prepend: true

  scope :default, -> { where(default: true).first }

  def default?
    default
  end

  def deletable?
    default
  end

  private

  def prevent_default_category_deletion
    throw(:abort) if !deletable? && default?
  end

  def transfer_expenses_to_default
    default_category = user.expense_categories.find_by(default: true)
    expense_transactions.each do |expense|
      expense.update(expense_category: default_category)
    end
  end
end
