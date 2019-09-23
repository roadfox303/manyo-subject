class AddIndexStatusesStateId < ActiveRecord::Migration[5.2]
  def change
    add_index :statuses, :state_id
  end
end
