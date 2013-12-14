class AddEmailActivation < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, :null => false
    add_column :users, :activation_token, :string, :null => false
  end
end
