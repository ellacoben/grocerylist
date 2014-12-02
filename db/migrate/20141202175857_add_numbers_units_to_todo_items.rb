class AddNumbersUnitsToTodoItems < ActiveRecord::Migration
  def change
  	change_table :todo_items do |table|
  		table.integer :number
  		table.string :unit
  	end
  end
end
