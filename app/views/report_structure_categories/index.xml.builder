xml.instruct!
xml.opt do
  @categories.each do |cat|
    xml.category(:name => cat.name) do
      cat.elements.each do |elem|
        xml.item(:name => elem.name, :type => elem.type.name,
          :shopcategory => elem.shop_types, :weight => elem.weight)
      end
    end
  end
  
end