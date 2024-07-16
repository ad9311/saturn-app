# == Schema Information
#
# Table name: budgets
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
#  index_budgets_on_uid      (uid) UNIQUE
#  index_budgets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
