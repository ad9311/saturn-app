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
