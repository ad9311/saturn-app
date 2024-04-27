# == Schema Information
#
# Table name: transactions
#
#  id                      :bigint           not null, primary key
#  amount                  :decimal(11, 2)   not null
#  description             :string           not null
#  transaction_type        :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  budget_period_id        :bigint           not null
#  transaction_category_id :bigint           not null
#
# Indexes
#
#  index_transactions_on_budget_period_id         (budget_period_id)
#  index_transactions_on_transaction_category_id  (transaction_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_period_id => budget_periods.id)
#  fk_rails_...  (transaction_category_id => transaction_categories.id)
#
class Transaction < Applicationtransaction
  belongs_to :budget_period
  belongs_to :transaction_category

  validates :description, presence: true, length: { minimum: 1, maximum: 100 }
  validates :amount, numericality: { greater_than: 0 }

  enum transaction_type: { income: 0, expense: 1 }

  after_create do |transaction|
    increase_budget_period_transaction_count
    if transaction.income?
      add_amount_to_budget_period_balance(amount)
      add_amount_to_budget_period_total_income(amount)
      increase_budget_period_income_count
    else
      substract_amount_from_budget_period_balance(amount)
      add_amount_to_budget_period_total_expnses(amount)
      increase_budget_period_expense_count
    end
  end

  after_update do |transaction|
    if saved_change_to_amount?
      if transaction.income?
        add_amount_to_budget_period_balance(amount)
        add_amount_to_budget_period_total_income(amount)
      else
        substract_amount_from_budget_period_balance(amount)
        add_amount_to_budget_period_total_expnses(amount)
      end
    end
  end

  before_destroy do |transaction|
    decrease_budget_period_transaction_count
    if transaction.income?
      substract_amount_from_budget_period_balance(amount)
      substract_amount_from_budget_period_total_income(amount)
      decrease_budget_period_income_count
    else
      add_amount_to_budget_period_balance(amount)
      substract_amount_from_budget_period_total_expnses(amount)
      decrease_budget_period_expense_count
    end
  end

  before_update do |transaction|
    if amount_changed?
      if transaction.income?
        substract_amount_from_budget_period_balance(amount_was)
        substract_amount_from_budget_period_total_income(amount_was)
      else
        add_amount_to_budget_period_balance(amount_was)
        substract_amount_from_budget_period_total_expnses(amount_was)
      end
    end
  end

  private

  def add_amount_to_budget_period_balance(new_amount)
    balance = budget_period.balance + new_amount
    budget_period.update(balance:)
  end

  def substract_amount_from_budget_period_balance(new_amount)
    balance = budget_period.balance - new_amount
    budget_period.update(balance:)
  end

  def add_amount_to_budget_period_total_income(new_amount)
    total_income = budget_period.total_income
    budget_period.update(total_income: total_income + new_amount)
  end

  def add_amount_to_budget_period_total_expnses(new_amount)
    total_expenses = budget_period.total_expenses
    budget_period.update(total_expenses: total_expenses + new_amount)
  end

  def substract_amount_from_budget_period_total_income(new_amount)
    total_income = budget_period.total_income
    budget_period.update(total_income: total_income - new_amount)
  end

  def substract_amount_from_budget_period_total_expnses(new_amount)
    total_expenses = budget_period.total_expenses
    budget_period.update(total_expenses: total_expenses - new_amount)
  end

  def increase_budget_period_transaction_count
    transaction_count = budget_period.transaction_count + 1
    budget_period.update(transaction_count:)
  end

  def decrease_budget_period_transaction_count
    transaction_count = budget_period.transaction_count - 1
    budget_period.update(transaction_count:)
  end

  def increase_budget_period_income_count
    income_count = budget_period.income_count + 1
    budget_period.update(income_count:)
  end

  def increase_budget_period_expense_count
    expense_count = budget_period.income_count + 1
    budget_period.update(expense_count:)
  end

  def decrease_budget_period_income_count
    income_count = budget_period.income_count - 1
    budget_period.update(income_count:)
  end

  def decrease_budget_period_expense_count
    expense_count = budget_period.income_count - 1
    budget_period.update(expense_count:)
  end
end
