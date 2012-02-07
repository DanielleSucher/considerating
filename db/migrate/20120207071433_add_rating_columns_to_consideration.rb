class AddRatingColumnsToConsideration < ActiveRecord::Migration
  def change
  	add_column :considerations, :v1, :integer, :null => false, :default => 0
  	add_column :considerations, :v2, :integer, :null => false, :default => 0
  	add_column :considerations, :v3, :integer, :null => false, :default => 0
  	add_column :considerations, :v4, :integer, :null => false, :default => 0
  	add_column :considerations, :v5, :integer, :null => false, :default => 0
  	add_column :considerations, :v6, :integer, :null => false, :default => 0
  	add_column :considerations, :v7, :integer, :null => false, :default => 0
  	add_column :considerations, :v8, :integer, :null => false, :default => 0
  	add_column :considerations, :v9, :integer, :null => false, :default => 0
  	add_column :considerations, :v10, :integer, :null => false, :default => 0
  end
end
