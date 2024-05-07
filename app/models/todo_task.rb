# == Schema Information
#
# Table name: todo_tasks
#
#  id           :bigint           not null, primary key
#  description  :text             not null
#  done         :boolean          default(FALSE), not null
#  done_at      :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  todo_list_id :bigint           not null
#
# Indexes
#
#  index_todo_tasks_on_todo_list_id  (todo_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (todo_list_id => todo_lists.id)
#
class TodoTask < ApplicationRecord
  belongs_to :todo_list

  validates :description, presence: true, length: { minimum: 1, maximum: 20 }

  def done?
    done
  end
end
