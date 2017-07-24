class AddAccuracyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accuracy, :float, default: 0.0
  end
end
