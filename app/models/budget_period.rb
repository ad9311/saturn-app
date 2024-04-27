# == Schema Information
#
# Table name: budget_periods
#
#  id                :bigint           not null, primary key
#  balance           :decimal(11, 2)   default(0.0), not null
#  expense_count     :integer          default(0), not null
#  income_count      :integer          default(0), not null
#  month             :integer          not null
#  total_expenses    :decimal(11, 2)   default(0.0), not null
#  total_income      :decimal(11, 2)   default(0.0), not null
#  transaction_count :integer          default(0), not null
#  uid               :integer          not null
#  year              :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_budget_periods_on_uid      (uid) UNIQUE
#  index_budget_periods_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BudgetPeriod < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy
  has_many :income_transactions, dependent: :destroy
  has_many :expense_transactions, dependent: :destroy

  validates :uid, uniqueness: true
  validates :balance, numericality: true
  validates(
    :month,
    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  )
  validates(
    :year,
    numericality: { only_integer: true, greater_than_or_equal_to: 2000, less_than_or_equal_to: 3000 }
  )

  before_save :set_uid

  private

  def set_uid
    self.uid = "#{year}#{month.to_s.rjust(2, '0')}".to_i
  end
end
