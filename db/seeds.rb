require 'faker'

user = User.create(
  email: 'diazangel9311@gmail.com',
  password: '123456789',
  password_confirmation: '123456789',
  first_name: 'Ángel',
  last_name: 'Díaz'
)

TransactionCategory.create(user:, name: 'Groceries', color: '#FF5722')
TransactionCategory.create(user:, name: 'Online shopping', color: '#FF5722')
TransactionCategory.create(user:, name: 'Utilities', color: '#28B600')
TransactionCategory.create(user:, name: 'Subscriptions', color: '#B60000')
TransactionCategory.create(user:, name: 'Other', color: '#B69500')

(1..12).each do |month|
  budget_period = BudgetPeriod.create(user:, month:, year: 2023)
  Faker::Number.between(from: 1, to: 10).times do
    Transaction.create(
      transaction_category: user.transaction_categories.sample,
      budget_period:,
      description: Faker::Commerce.product_name,
      amount: Faker::Commerce.price,
      transaction_type: Faker::Number.between(from: 0, to: 1)
    )
  end
end
