class ChangeArtworksTable < ActiveRecord::Migration[7.1]
  def change
    # Remove artist_id column if it exists
    remove_column :artworks, :artist_id, :bigint, if_exists: true

    # Add user_id column
    add_column :artworks, :user_id, :bigint, null: false

    # Add index for user_id
    add_index :artworks, :user_id
  end
end
