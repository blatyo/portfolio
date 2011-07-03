class CreateCategoryAssociations < ActiveRecord::Migration
  def change
    create_table :category_associations do |t|
      t.integer :category_id
      t.integer :categorical_id
      t.string :categorical_type

      t.timestamps
    end
  end
end
