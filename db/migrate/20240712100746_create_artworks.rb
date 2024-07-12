class CreateArtworks < ActiveRecord::Migration[7.1]
  def change
    create_table :artworks do |t|
      t.string :artist_name
      t.string :title
      t.string :medium
      t.string :price_per_month
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
