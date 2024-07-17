# == Schema Information
#
# Table name: expense_transactions
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(, )
#  description         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  budget_id           :bigint           not null
#  expense_category_id :bigint           not null
#
# Indexes
#
#  index_expense_transactions_on_budget_id            (budget_id)
#  index_expense_transactions_on_expense_category_id  (expense_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (expense_category_id => expense_categories.id)
#
module ExpenseSerializer
  include Serializer

  private

  def attributes(_options)
    {
      id:,
      amount:,
      description:,
      expense_category: expense_category.serialized_hash
    }
  end
end
