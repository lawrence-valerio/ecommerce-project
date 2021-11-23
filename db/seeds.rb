require 'json'
require 'net/http'

CardType.destroy_all
Rarity.destroy_all
Type.destroy_all
Card.destroy_all
Province.destroy_all

url = 'https://api.pokemontcg.io/v2/cards'
uri = URI(url)
response = Net::HTTP.get(uri)
apiData = JSON.parse(response)

apiData['data'].each do |card_single|
  if card_single['rarity'].nil?
    rarity = Rarity.find_or_create_by(
      rarity_name: 'Not Available'
    )
  elsif rarity = Rarity.find_or_create_by(
    rarity_name: card_single['rarity']
  )
  end

  card = Card.create(
    name: card_single['name'],
    level: card_single['level'],
    hp: card_single['hp'],
    price: Faker::Commerce.price,
    image: card_single['images']['large'],
    image_thumbnail: card_single['images']['small'],
    rarity: rarity
  )

  card_single['types'].each do |type_name_single|
    type = Type.find_or_create_by(
      type_name: type_name_single
    )
    CardType.create(card: card, type: type)
  end
end

# getting provinces
jsonFile = File.read('db/provinces.json')
jsonData = JSON.parse(jsonFile)

jsonData.each do |_, object|
  hst = 0
  gst = 0
  pst = 0
  object['taxes'].each do |tax|
    case tax['code']
    when 'HST'
      hst = tax['tax']
    when 'GST'
      gst = tax['tax']
    when 'PST'
      pst = tax['tax']
    end
  end

  province = Province.create(
    province_name: object['name'],
    hst: hst,
    gst: gst,
    pst: pst
  )
end

# if Rails.env.development?
#   AdminUser.create!(email: 'admin@example.com', password: 'password',
#                     password_confirmation: 'password')
# end
