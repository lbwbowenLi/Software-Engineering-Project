class Changejointablename < ActiveRecord::Migration
  def change
      rename_table :users_groups, :groups_users
  end
end
