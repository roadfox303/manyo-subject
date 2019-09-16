class ChangeColumnNullCommentFromTask < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :comment, false
  end
end
