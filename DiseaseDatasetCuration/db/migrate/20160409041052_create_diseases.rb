class CreateDiseases < ActiveRecord::Migration
  def change
    create_table :diseases do |t|
      t.string :disease
      t.string :accession
      t.text  :questions
      t.timestamps null: false
    end
  end
end
