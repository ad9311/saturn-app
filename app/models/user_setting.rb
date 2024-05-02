# == Schema Information
#
# Table name: user_settings
#
#  id         :bigint           not null, primary key
#  locale     :string           default("en"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_settings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserSetting < ApplicationRecord
  belongs_to :user

  validates :locale, inclusion: { in: %w[en es] }
end
