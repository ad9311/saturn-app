# == Schema Information
#
# Table name: todo_tasks
#
#  id           :bigint           not null, primary key
#  done         :boolean          default(FALSE), not null
#  text         :text             not null
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
end
