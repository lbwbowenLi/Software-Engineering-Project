class Changenameonpartial < ActiveRecord::Migration
  def change
      
      rename_column(:partsearchresults,:data_set_results,:Data_set_results)
      
      
  end
end
