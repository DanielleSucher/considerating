class EnlargeConsiderationContent < ActiveRecord::Migration
  def up
  	change_column :considerations, :content, :text, :limit => nil
  end

  def down
  	change_column :considerations, :content, :string
  end
end
