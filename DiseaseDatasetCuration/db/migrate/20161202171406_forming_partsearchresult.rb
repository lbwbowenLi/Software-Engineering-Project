class FormingPartsearchresult < ActiveRecord::Migration
  def change
      
      add_column :partsearchresults, :keyword, :string
      add_column :partsearchresults, :data_set_results, :text
      
      
      
      
      
  end
end
