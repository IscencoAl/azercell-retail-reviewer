# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop_item do
    item
    shop
  end

  factory :shop_item_with_existing_elements, :class => ShopItem do
    shop { Shop.all.to_a.sample }
    item { Item.all.to_a.sample }
  end
end
