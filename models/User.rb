class User < ActiveRecord::Base
	has_many :todo_items
	has_secure_password
	validates :password,
    	:length => { :minimum => 5 }
    validates_confirmation_of :password
end