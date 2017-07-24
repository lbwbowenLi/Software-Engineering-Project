class AddQuestionAdmintoUsers < ActiveRecord::Migration
  def change
    add_column :users, :addquestion_admin, :boolean, default:false
  end
end
