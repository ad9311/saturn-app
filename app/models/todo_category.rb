# == Schema Information
#
# Table name: todo_categories
#
#  id           :bigint           not null, primary key
#  color        :string           not null
#  default      :boolean          default(FALSE), not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  todo_list_id :bigint           not null
#
# Indexes
#
#  index_todo_categories_on_todo_list_id  (todo_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (todo_list_id => todo_lists.id)
#
class TodoCategory < ApplicationRecord
  belongs_to :todo_list

  has_many :todo_tasks, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 25 }
  validates :color, presence: true, length: { is: 7 }

  scope :default, -> { where(default: true).first }

  def default?
    default
  end
end
