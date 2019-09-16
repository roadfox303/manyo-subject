class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null:false
      t.text :comment
      t.integer :priority, null:false, default:0
      t.datetime :deadline
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
