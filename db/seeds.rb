user = User.create(
  email: 'diazangel9311@gmail.com',
  password: '123456789',
  password_confirmation: '123456789',
  first_name: 'Ángel',
  last_name: 'Díaz'
)
transaction_category = TransactionCategory.create(user:, name: 'Groceries', color: 'ffffff')
budget_period = BudgetPeriod.create(user:, month: 1, year: 2010)
Transaction.create(
  transaction_category:,
  budget_period:,
  description: 'This is a test',
  amount: 100.0,
  transaction_type: :income
)
Transaction.create(
  transaction_category:,
  budget_period:,
  description: 'This is another test',
  amount: 5.0,
  transaction_type: :expense
)
