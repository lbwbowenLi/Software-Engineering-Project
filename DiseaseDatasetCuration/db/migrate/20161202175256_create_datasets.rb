class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :name
      t.text :Data_set

      t.timestamps null: false
    end
  end
end
