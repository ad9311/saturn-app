require 'faker'

user = User.create(
  email: 'diazangel9311@gmail.com',
  password: '123456789',
  password_confirmation: '123456789',
  first_name: 'Ángel',
  last_name: 'Díaz'
)

ExpenseCategory.create(user:, name: 'Groceries', color: '#FF5722')
ExpenseCategory.create(user:, name: 'Online shopping', color: '#FF5722')
ExpenseCategory.create(user:, name: 'Utilities', color: '#28B600')
ExpenseCategory.create(user:, name: 'Subscriptions', color: '#B60000')
ExpenseCategory.create(user:, name: 'Other', color: '#B69500')

(1..12).each do |month|
  budget_period = BudgetPeriod.create(user:, month:, year: 2023)
  Faker::Number.between(from: 1, to: 10).times do
    if Faker::Number.between(from: 1, to: 10).even?
      IncomeTransaction.create(
        budget_period:,
        description: Faker::Commerce.product_name,
        amount: Faker::Commerce.price
      )
    else
      ExpenseTransaction.create(
        expense_category: user.expense_categories.sample,
        budget_period:,
        description: Faker::Commerce.product_name,
        amount: Faker::Commerce.price
      )
    end
  end
end
