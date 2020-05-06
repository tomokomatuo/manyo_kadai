class AddTasksIndexToColumnIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, [:title, :condition, :dead_line]
  end
end
