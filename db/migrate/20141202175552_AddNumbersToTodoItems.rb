class AddNumbersToTodoItems < ActiveRecord::Migration
  def change
  	create_table :todo_items do |table|
  		table.integer :number
  end
end
