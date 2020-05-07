class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text   :content
      t.string :dead_line
      t.string :condition
      t.string :priority
      t.string :author
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
