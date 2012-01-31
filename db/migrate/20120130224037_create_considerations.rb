class CreateConsiderations < ActiveRecord::Migration
  def change
    create_table :considerations do |t|
      t.string :content
      t.integer :uid

      t.timestamps
    end
    add_index :considerations, [:uid, :created_at]
  end
end
