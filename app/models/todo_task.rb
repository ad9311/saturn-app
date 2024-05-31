# == Schema Information
#
# Table name: todo_tasks
#
#  id               :bigint           not null, primary key
#  description      :text             not null
#  done             :boolean          default(FALSE), not null
#  done_at          :datetime
#  priority         :integer          default("default"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  todo_category_id :bigint           not null
#  todo_list_id     :bigint           not null
#
# Indexes
#
#  index_todo_tasks_on_todo_category_id  (todo_category_id)
#  index_todo_tasks_on_todo_list_id      (todo_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (todo_category_id => todo_categories.id)
#  fk_rails_...  (todo_list_id => todo_lists.id)
#
class TodoTask < ApplicationRecord
  belongs_to :todo_list
  belongs_to :todo_category

  validates :description, presence: true, length: { minimum: 1, maximum: 20 }

  enum priority: { default: 0, low: 1, medium: 2, high: 3 }

  before_validation :assign_default_category, on: :create

  def done?
    done
  end

  private

  def assign_default_category
    return unless todo_category_id.nil?

    self.todo_category_id = todo_list.todo_categories.default.first.id
  end
end
