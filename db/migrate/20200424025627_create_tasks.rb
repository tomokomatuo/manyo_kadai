class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text   :content
      t.date :dead_line
      t.string :condition
      t.integer :priority
      t.string :author

      t.timestamps
    end
  end
end
