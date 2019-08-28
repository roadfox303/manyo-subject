class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.integer :task_id
      t.integer :state_id

      t.timestamps
    end
  end
end
