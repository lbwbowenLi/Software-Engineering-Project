class AddOauthTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :oauth_token, :string
  end
end
