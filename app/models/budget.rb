# == Schema Information
#
# Table name: budgets
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
#  index_budgets_on_uid      (uid) UNIQUE
#  index_budgets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Budget < ApplicationRecord
  belongs_to :user

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

  include BudgetSerializer

  before_save :set_uid

  def rectify_period
    data = {
      balance: 0.0,
      total_income: 0.0,
      total_expenses: 0.0,
      transaction_count: 0,
      income_count: 0,
      expense_count: 0
    }
    income_transactions.each do |i|
      data[:balance] += i.amount
      data[:total_income] += i.amount
      data[:transaction_count] += 1
      data[:income_count] += 1
    end
    expense_transactions.each do |i|
      data[:balance] -= i.amount
      data[:total_expenses] += i.amount
      data[:transaction_count] += 1
      data[:expense_count] += 1
    end
    update(data)
  end

  private

  def set_uid
    self.uid = "#{user.id}#{year}#{month.to_s.rjust(2, '0')}".to_i
  end
end
