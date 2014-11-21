json.categories @categories do |cat|
  json.id cat.id
  json.name cat.name
  json.elements cat.elements do |elem|
    json.id elem.id
    json.name elem.name
    json.type elem.type.name
    json.shop_category elem.shop_types
    json.weight elem.weight
  end
end