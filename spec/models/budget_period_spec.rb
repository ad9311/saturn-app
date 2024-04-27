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
require 'rails_helper'

RSpec.describe BudgetPeriod, type: :model do
  before(:context) do
    @user = User.create(
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'Jon',
      last_name: 'Doe'
    )
    @transaction_category = TransactionCategory.create(
      name: 'Groceries',
      color: '#FFFFFF'
    )
    @budget_period = BudgetPeriod.create(
      user: @user,
      month: 1,
      year: 2024
    )
  end
end
