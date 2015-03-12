# this seeds the database
products = JSON.parse(File.read("db/toys.json"))
total_product_count = 0
products.each_with_index do |product_hash| 
  Product.create(product_hash)
  total_product_count += 1
end