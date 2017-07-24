class CreateFullsubmissions < ActiveRecord::Migration
  def change
    create_table :fullsubmissions do |t|  

      t.timestamps null: false
    end
  end
end
