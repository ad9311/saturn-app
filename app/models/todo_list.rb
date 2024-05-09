# == Schema Information
#
# Table name: todo_lists
#
#  id          :bigint           not null, primary key
#  categorized :boolean          default(FALSE), not null
#  name        :string           not null
#  prioritized :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_todo_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class TodoList < ApplicationRecord
  belongs_to :user

  has_many :todo_tasks, dependent: :destroy
  has_many :todo_categories, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 25 }

  after_create :create_default_category

  private

  def create_default_category
    todo_categories.create(name: 'default', color: '#000000', default: true)
  end
end
