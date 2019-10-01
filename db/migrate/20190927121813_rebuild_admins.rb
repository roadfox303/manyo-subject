class RebuildAdmins < ActiveRecord::Migration[5.2]
  def change
    remove_column :admins, :name, :string
    remove_column :admins, :email, :string
    remove_column :admins, :password_digest, :string
    add_reference :admins, :user, null: false, index: { unique: true }, foreign_key: true
  end
end
