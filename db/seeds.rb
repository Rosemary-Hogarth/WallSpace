# db/seeds.rb

# Clear existing data
puts "Clearing existing data..."
# Rental.destroy_all
Artwork.destroy_all
User.destroy_all

# Create Users
puts "Creating users..."
user1 = User.create!(
  email: "artist1@example.com",
  password: "password",
  is_artist: true,
  name: "Artist One",
  city: "New York"
)

user2 = User.create!(
  email: "artist2@example.com",
  password: "password",
  is_artist: true,
  name: "Artist Two",
  city: "Los Angeles"
)

user3 = User.create!(
  email: "renter@example.com",
  password: "password",
  is_artist: false,
  name: "Art Enthusiast",
  city: "Chicago"
)

# # Create Artworks
# puts "Creating artworks..."
# artwork1 = Artwork.create!(
#   artist_name: "Artist One",
#   title: "Sunset Dreams",
#   medium: "Oil on Canvas",
#   price_per_month: 50.00,
#   user: user1
# )

# artwork2 = Artwork.create!(
#   artist_name: "Artist One",
#   title: "Urban Jungle",
#   medium: "Acrylic on Wood",
#   price_per_month: 40.00,
#   user: user1
# )

# artwork3 = Artwork.create!(
#   artist_name: "Artist Two",
#   title: "Abstract Thoughts",
#   medium: "Mixed Media",
#   price_per_month: 60.00,
#   user: user2
# )

# Attach images to artworks
# puts "Attaching images to artworks..."
# artwork1.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'seed', 'artwork1.jpg')), filename: 'artwork1.jpg', content_type: 'image/jpeg')
# artwork2.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'seed', 'artwork2.jpg')), filename: 'artwork2.jpg', content_type: 'image/jpeg')
# artwork3.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'seed', 'artwork3.jpg')), filename: 'artwork3.jpg', content_type: 'image/jpeg')

# Create Rentals
# puts "Creating rentals..."
# Rental.create!(
#   user: user3,
#   artwork: artwork1,
#   start_date: Date.today,
#   end_date: Date.today + 7.days,
#   total_price: 350.00,
#   status: "approved"
# )

# Rental.create!(
#   user: user3,
#   artwork: artwork2,
#   start_date: Date.today + 14.days,
#   end_date: Date.today + 21.days,
#   total_price: 280.00,
#   status: "pending"
# )

puts "Seed data created successfully!"
