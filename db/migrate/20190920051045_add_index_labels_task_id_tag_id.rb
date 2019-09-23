class AddIndexLabelsTaskIdTagId < ActiveRecord::Migration[5.2]
  def change
    add_index :labels, :task_id
    add_index :labels, :tag_id
  end
end
