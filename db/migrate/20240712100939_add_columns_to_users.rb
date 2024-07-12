class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_artist, :boolean
    add_column :users, :name, :string
    add_column :users, :city, :string
  end
end
