class AddVotesTotal < ActiveRecord::Migration
  def up
  	add_column :considerations, :votes_total, :decimal, :precision => 4, :scale => 2, :null => false, :default => 0
  end

  def down
  	remove_column :considerations, :votes_total
  end
end
