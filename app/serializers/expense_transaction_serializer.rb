module ExpenseTransactionSerializer
  include Serializer

  private

  def attributes
    {
      id:,
      amount:,
      description:,
      category: {
        name: expense_category.name,
        color: expense_category.color
      }
    }
  end
end
