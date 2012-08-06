class AddBasicUserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :forename, :string
    add_column :users, :surname, :string
    add_column :users, :phone, :string
  end
end
