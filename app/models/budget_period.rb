# == Schema Information
#
# Table name: budget_periods
#
#  id         :bigint           not null, primary key
#  balance    :float            default(0.0), not null
#  month      :integer          not null
#  year       :integer          not null
#  year_month :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_budget_periods_on_user_id     (user_id)
#  index_budget_periods_on_year_month  (year_month) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BudgetPeriod < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy
end
