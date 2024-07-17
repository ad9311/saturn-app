module ExpenseCategorySerializer
  include Serializer

  private

  def attributes(_options)
    { id:, name:, color: }
  end
end
