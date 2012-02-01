class AddRating < ActiveRecord::Migration
  def up
  	add_column :votes, :rating, :decimal, :precision => 4, :scale => 2, :null => false, :default => 0
  end

  def down
  	remove_column :votes, :rat
  end
end
