#<!-- grocery list -->
class TodoItem < ActiveRecord::Base
	belongs_to :user
end