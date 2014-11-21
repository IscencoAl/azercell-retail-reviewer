json.dealers @shops_by_dealer.each do |dealer, cities|
  json.id dealer.id
  json.name dealer.name
  json.cities cities.each do |city, shops|
    json.id city.id
    json.name city.name
    json.shops shops do |shop|
      json.id shop.id
      json.address shop.address
      json.shopcategory shop.type.abbreviation
    end
  end
end