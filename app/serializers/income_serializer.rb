# == Schema Information
#
# Table name: income_transactions
#
#  id          :bigint           not null, primary key
#  amount      :decimal(11, 2)   not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  budget_id   :bigint           not null
#
# Indexes
#
#  index_income_transactions_on_budget_id  (budget_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#
module IncomeSerializer
  include Serializer

  private

  def attributes(_options)
    { id:, amount:, description: }
  end
end
