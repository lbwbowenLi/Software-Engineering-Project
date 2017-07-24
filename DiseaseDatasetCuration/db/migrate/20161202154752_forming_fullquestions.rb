class FormingFullquestions < ActiveRecord::Migration
  def change
      add_column :fullquestions, :qcontent, :text, :null => false, :default =>"Default question description"
      add_column :fullquestions, :qanswer, :string
      add_column :fullquestions, :ds_name, :string
      add_column :fullquestions, :ds_accession, :string
      add_column :fullquestions, :closed, :boolean, default: false 
      add_column :fullquestions, :yes_users, :integer, default: 0
      add_column :fullquestions, :no_users, :integer, default: 0
      
      
      
  end
end
