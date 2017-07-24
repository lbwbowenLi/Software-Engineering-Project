class AddGroupAdmintoUsers < ActiveRecord::Migration
  def change
    add_column :users, :group_admin, :boolean, default:false
  end
  
end
