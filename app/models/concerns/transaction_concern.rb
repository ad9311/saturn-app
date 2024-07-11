module TransactionConcern
  def credit_budget_period!(new_amount)
    balance = budget_period.balance + new_amount
    budget_period.update(balance:)
  end

  def debit_budget_period!(new_amount)
    balance = budget_period.balance - new_amount
    budget_period.update(balance:)
  end

  def increment_transaction_count!
    transaction_count = budget_period.transaction_count + 1
    budget_period.update(transaction_count:)
  end

  def decrement_transaction_count!
    transaction_count = budget_period.transaction_count - 1
    budget_period.update(transaction_count:)
  end

  module Income
    def credit_total_income!(new_amount)
      total_income = budget_period.total_income
      budget_period.update(total_income: total_income + new_amount)
    end

    def debit_total_income!(new_amount)
      total_income = budget_period.total_income
      budget_period.update(total_income: total_income - new_amount)
    end

    def increment_income_count!
      income_count = budget_period.income_count + 1
      budget_period.update(income_count:)
    end

    def decrement_income_count!
      income_count = budget_period.income_count - 1
      budget_period.update(income_count:)
    end
  end

  module Expenses
    def credit_total_expense!(new_amount)
      total_expenses = budget_period.total_expenses
      budget_period.update(total_expenses: total_expenses + new_amount)
    end

    def debit_total_expense!(new_amount)
      total_expenses = budget_period.total_expenses
      budget_period.update(total_expenses: total_expenses - new_amount)
    end

    def increment_expense_count!
      expense_count = budget_period.expense_count + 1
      budget_period.update(expense_count:)
    end

    def decrement_expense_count!
      expense_count = budget_period.expense_count - 1
      budget_period.update(expense_count:)
    end
  end
end
