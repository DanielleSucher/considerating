class RenameConsiderationUid < ActiveRecord::Migration
  	def change
    	change_table :considerations do |t|
      		t.rename :uid, :user_id
    	end
  		add_index :considerations, [:user_id]
  	end
end
