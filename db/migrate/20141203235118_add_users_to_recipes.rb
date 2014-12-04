class AddUsersToRecipes < ActiveRecord::Migration
  def change
  	change_table :recipes do |table|
  		table.integer :user_id
  	end
  end
end
