class Artwork < ApplicationRecord
  belongs_to :user
  has_many :rentals
  # has_one_attached :image
  has_many_attached :images
  validates :artist_name, presence: true
  validates :title, presence: true
  validates :price_per_month, presence: true, numericality: { greater_than: 0 }
  before_save :normalize_medium
  validates :width, :height, numericality: { greater_than: 0 }, allow_nil: true

  def self.search_by_artist_name_title_medium(query)
    where("artist_name ILIKE :query OR title ILIKE :query OR medium ILIKE :query", query: "%#{query}%")
  end

  private

  def normalize_medium
    self.medium = medium.downcase.strip if medium.present?
  end

  def check_image_attachment
    if images.attached?
      puts "Images attached successfully. Count: #{images.count}"
    else
      puts "No images attached to this artwork."
    end
  end
end
