class AddVotesCount < ActiveRecord::Migration
  def up
  	add_column :considerations, :votes_count, :integer, :null => false, :default => 0
  end

  def down
    remove_column :considerations, :votes_count
  end
end
