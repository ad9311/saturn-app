# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise(
    :database_authenticatable,
    # :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :trackable
  )

  has_one  :setting, dependent: :destroy
  has_many :budget_periods, dependent: :destroy
  has_many :income_transactions, through: :budget_periods
  has_many :expense_transactions, through: :budget_periods
  has_many :expense_categories, dependent: :destroy

  before_destroy :prepare_destroy, prepend: true

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def prepare_destroy
    expense_categories.default.update(deletable: true)
  end
end
