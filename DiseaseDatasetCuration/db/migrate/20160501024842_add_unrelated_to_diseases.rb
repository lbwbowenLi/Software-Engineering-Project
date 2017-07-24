class AddUnrelatedToDiseases < ActiveRecord::Migration
  def change
    add_column :diseases, :unrelated, :integer, default: 0
  end
end
