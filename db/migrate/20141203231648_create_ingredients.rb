class CreateIngredients < ActiveRecord::Migration
  def change
  	create_table :ingredients do |table|
  		table.string :description
  		table.integer :recipe_id
  		table.integer :number
  		table.string :unit
  	end
  end
end
