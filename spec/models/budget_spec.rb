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

RSpec.describe Budget, type: :model do
  before(:context) do
    @user = User.create(
      email: 'budgettest@test.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'Jon',
      last_name: 'Doe'
    )
    @expense_category = ExpenseCategory.create(
      user: @user,
      name: 'Groceries',
      color: '#FFFFFF'
    )
    @budget = Budget.create(
      user: @user,
      month: 1,
      year: 2024
    )
  end

  it 'increments the budget period balance' do
    @budget.income_transactions.create(description: 'test', amount: 1_000.0)
    expect(@budget.balance.to_f).to eq(1000.0)
  end

  it 'has transaction count to 1' do
    expect(@budget.transaction_count).to eq(1)
  end

  it 'has income count to 1' do
    expect(@budget.income_count).to eq(1)
  end

  it 'has total income to the same value of balance' do
    expect(@budget.total_income.to_f).to eq(1000.0)
  end

  it 'decrements the budget period balance' do
    @budget.expense_transactions.create(
      expense_category: @expense_category,
      description: 'test',
      amount: 500.0
    )
    expect(@budget.balance.to_f).to eq(500.0)
  end

  it 'has transaction count to 2' do
    expect(@budget.transaction_count).to eq(2)
  end

  it 'has expense count to 1' do
    expect(@budget.expense_count).to eq(1)
  end

  it 'has total expenses to the same value of last expense' do
    expect(@budget.total_expenses.to_f).to eq(500.0)
  end

  it 'reverts balance back when an income is destroyed' do
    income = @budget.income_transactions.create(description: 'test', amount: 50.0)
    income.destroy
    expect(@budget.balance.to_f).to eq(500.0)
  end

  it 'has transaction count to 2 after deleting last income' do
    expect(@budget.transaction_count).to eq(2)
  end

  it 'has income count to 1 after deleting last income' do
    expect(@budget.income_count).to eq(1)
  end

  it 'has total income of 500 after deleting last income' do
    expect(@budget.total_income.to_f).to eq(1000.0)
  end

  it 'reverts balance back when an expense is destroyed' do
    expense = @budget.expense_transactions.create(
      expense_category: @expense_category,
      description: 'test',
      amount: 50.0
    )
    expense.destroy
    expect(@budget.balance.to_f).to eq(500.0)
  end

  it 'has transaction count to 2 after destroying last expense' do
    expect(@budget.transaction_count).to eq(2)
  end

  it 'has expense count to 1 after destroying last expense' do
    expect(@budget.expense_count).to eq(1)
  end

  it 'has total expenses to the same value of last expense' do
    expect(@budget.total_expenses.to_f).to eq(500.0)
  end

  it 'corrects the balance when an income is updated' do
    income = @budget.income_transactions.create(description: 'test', amount: 50.0)
    income.update(amount: 20.0)
    expect(@budget.balance.to_f).to eq(520.0)
  end

  it 'has total income of all income' do
    expect(@budget.total_income.to_f).to eq(1020.0)
  end

  it 'corrects the balance when an expense is updated' do
    expense = @budget.expense_transactions.create(
      expense_category: @expense_category,
      description: 'test',
      amount: 10.0
    )
    expense.update(amount: 20.0)
    expect(@budget.balance.to_f).to eq(500.0)
  end

  it 'has total expenses of all expenses' do
    expect(@budget.total_expenses.to_f).to eq(520.0)
  end
end
