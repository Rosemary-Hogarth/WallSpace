class AddDimensionsToArtworks < ActiveRecord::Migration[7.1]
  def change
    add_column :artworks, :width, :float
    add_column :artworks, :height, :float
  end
end
