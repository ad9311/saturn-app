# == Schema Information
#
# Table name: budget_periods
#
#  id         :bigint           not null, primary key
#  balance    :decimal(11, 2)   default(0.0), not null
#  month      :integer          not null
#  year       :integer          not null
#  year_month :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_budget_periods_on_user_id     (user_id)
#  index_budget_periods_on_year_month  (year_month) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BudgetPeriod < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy

  validates :year_month, uniqueness: true
  validates :balance, numericality: true
  validates(
    :month,
    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  )
  validates(
    :year,
    numericality: { only_integer: true, greater_than_or_equal_to: 2000, less_than_or_equal_to: 3000 }
  )

  before_save :set_year_month

  private

  def set_year_month
    self.year_month = "#{year}#{month.to_s.rjust(2, '0')}".to_i
  end
end
