class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string  :link
      t.text    :site

      t.timestamps
    end
  end
end
