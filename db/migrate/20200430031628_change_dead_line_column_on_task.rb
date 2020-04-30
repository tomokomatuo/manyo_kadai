class ChangeDeadLineColumnOnTask < ActiveRecord::Migration[5.2]
  def up
    change_column_null :tasks, :dead_line, false
    change_column :tasks, :dead_line, :date, default: -> { 'NOW()' }
  end

  def down
    change_column_null :tasks, :dead_line, true
    change_column :tasks, :dead_line, :date, default: nil
  end
end
