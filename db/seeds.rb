require 'faker'

if Rails.env.development?
  user = User.create(
    email: 'example@gmail.com',
    password: '123456789',
    password_confirmation: '123456789',
    first_name: 'Ángel',
    last_name: 'Díaz'
  )

  ExpenseCategory.create(user:, name: 'default', color: '#000000', default: true)
  ExpenseCategory.create(user:, name: 'Groceries', color: '#FF5722')
  ExpenseCategory.create(user:, name: 'Online shopping', color: '#FF5722')
  ExpenseCategory.create(user:, name: 'Utilities', color: '#28B600')
  ExpenseCategory.create(user:, name: 'Subscriptions', color: '#B60000')
  ExpenseCategory.create(user:, name: 'Other', color: '#B69500')

  def year_period(year, user)
    (1..12).each do |month|
      break if Time.zone.now.month == month && Time.zone.now.year == year

      budget = Budget.create(user:, month:, year:)

      Faker::Number.between(from: 1, to: 50).times do
        if Faker::Number.between(from: 1, to: 10).even?
          IncomeTransaction.create(
            budget:,
            description: Faker::Commerce.product_name,
            amount: Faker::Commerce.price
          )
        else
          ExpenseTransaction.create(
            expense_category: user.expense_categories.where(default: false).sample,
            budget:,
            description: Faker::Commerce.product_name,
            amount: Faker::Commerce.price
          )
        end
      end
    end
  end

  (2020..2024).each do |year|
    year_period(year, user)
  end
end
