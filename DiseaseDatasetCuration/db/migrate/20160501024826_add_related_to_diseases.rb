class AddRelatedToDiseases < ActiveRecord::Migration
  def change
    add_column :diseases, :related, :integer, default: 0
  end
end
