class Artwork < ApplicationRecord
  belongs_to :user
  has_many :rentals
  has_one_attached :image

  validates :artist_name, presence: true
  validates :title, presence: true
  validates :price_per_month, presence: true, numericality: { greater_than: 0 }
  before_save :normalize_medium

  private

  def normalize_medium
    self.medium = medium.downcase.strip if medium.present?
  end
end
