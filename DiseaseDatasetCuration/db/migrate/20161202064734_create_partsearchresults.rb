class CreatePartsearchresults < ActiveRecord::Migration
  def change
    create_table :partsearchresults do |t|

      t.timestamps null: false
    end
  end
end
