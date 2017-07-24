class Changechoiceinfullsubmission < ActiveRecord::Migration
  def change
      
      change_column :fullsubmissions, :choice, :string
      
      
  end
end
