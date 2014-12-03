# grocery list
class User < ActiveRecord::Base
	has_many :todo_items
	has_many :recipes
	has_secure_password
end