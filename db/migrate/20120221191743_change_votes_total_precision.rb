class ChangeVotesTotalPrecision < ActiveRecord::Migration
  def up
  	change_column :considerations, :votes_total, :decimal, :precision => 20, :scale => 10, :null => false, :default => 0
  end

  def down
  	change_column :considerations, :votes_total, :decimal, :precision => 4, :scale => 2, :null => false, :default => 0
  end
end
