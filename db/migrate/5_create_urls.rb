class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string  :link
      t.integer :linkable_id
      t.string  :linkable_type
      t.timestamps
    end
  end
end
