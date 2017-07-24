class CreateFullquestions < ActiveRecord::Migration
  def change
    create_table :fullquestions do |t|

      t.timestamps null: false
    end
  end
end
