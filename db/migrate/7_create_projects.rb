class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :readme
      t.text :generated_readme

      t.timestamps
    end
  end
end
