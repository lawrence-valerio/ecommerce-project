require 'json'
require 'net/http'

# CardType.destroy_all
# Rarity.destroy_all
# Type.destroy_all
# Card.destroy_all

# url = 'https://api.pokemontcg.io/v2/cards'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# apiData = JSON.parse(response)

# apiData['data'].each do |card|
#   rarity = Rarity.find_or_create_by(
#     rarity_name: card['rarity']
#   )

#   card = Card.create(
#     name: card['name'],
#     level: card['level'],
#     hp: card['hp'],
#     rarity: rarity
#   )

#   card['types'].each do |typeName|
#     type = Type.find_or_Create(
#       type_name: typeName
#     )

#     cardTypes = CardType.create(type: type, card: card)
#   end
# end

# #getting provinces
# jsonFile = File.read('db/provinces.json')
# jsonData = JSON.parse(jsonFile)

# jsonData.each do |_, object|
#   province = Province.create(
#     province_name: object['name']
#   )
# end

# if Rails.env.development?
#   AdminUser.create!(email: 'admin@example.com', password: 'password',
#                     password_confirmation: 'password')
# end
