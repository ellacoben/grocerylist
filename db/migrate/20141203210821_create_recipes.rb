class CreateRecipes < ActiveRecord::Migration
  def change
  	create_table :recipes do |table|
  		table.string :recipe_name
  		table.string :instructions
  	end
  end
end
