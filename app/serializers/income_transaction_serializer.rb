module IncomeTransactionSerializer
  include Serializer

  private

  def attributes
    { id:, amount:, description: }
  end
end
