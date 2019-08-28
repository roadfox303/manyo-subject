class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :progress, null:false
      t.timestamps
    end
    add_index :states, :progress, unique: true
  end
end
