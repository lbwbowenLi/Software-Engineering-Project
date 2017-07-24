class FormingFullsubmissions < ActiveRecord::Migration
  def change
      
      add_reference :fullsubmissions, :user, index: true
      add_reference :fullsubmissions, :fullquestion, index: true
      add_column :fullsubmissions, :choice, :boolean
      add_column :fullsubmissions, :reason, :text
      
      
      
      
      
      
  end
end
