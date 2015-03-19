products = JSON.parse(File.read("db/toys.json"))
products.each { |p| Product.create(p) }