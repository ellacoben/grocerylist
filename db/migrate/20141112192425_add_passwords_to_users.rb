class AddPasswordsToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |table|
  		table.string :password_digest
  	end
  end
end
