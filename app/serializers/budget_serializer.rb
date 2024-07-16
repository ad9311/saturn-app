module BudgetSerializer
  include Serializer

  private

  def attributes
    {
      uid:,
      year:,
      month:,
      balance:,
      total_income:,
      total_expenses:,
      transaction_count:,
      expense_count:,
      income_count:
    }
  end
end
