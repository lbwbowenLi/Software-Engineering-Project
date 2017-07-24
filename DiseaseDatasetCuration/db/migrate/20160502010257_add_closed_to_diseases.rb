class AddClosedToDiseases < ActiveRecord::Migration
  def change
    add_column :diseases, :closed, :boolean, default: false
  end
end
