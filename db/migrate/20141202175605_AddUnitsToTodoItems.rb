class AddUnitsToTodoItems < ActiveRecord::Migration
  def change
  	create_table :todo_items do |table|
  		table.string :unit
  end
end
