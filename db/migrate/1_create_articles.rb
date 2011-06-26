class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string  :title
      t.text    :body
      t.text    :generated_body
      t.string  :category,      :default => "None"
      t.string  :tags,          :default => ""

      t.timestamps
    end
  end
end
