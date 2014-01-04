file_list = ['bin/shop_inventory',
 'lib/shop_inventory/orders',
 'lib/shop_inventory/customer.rb',
 'lib/shop_inventory/inventory',
 'lib/shop_inventory/product.rb',
 'lib/shop_inventory/shopkeeper.rb',
 'lib/shop_inventory/productactions.rb',
 'lib/shop_inventory.rb']

Gem::Specification.new do |s|
  s.name        = 'shop_inventory'
  s.version     = '1.0.0'
  s.executables << 'shop_inventory'
  s.date        = '2014-01-03'
  s.summary     = "Manage a small shop"
  s.description = "A simple console application to manage a shop's inventory"
  s.authors     = ["Sharang Dashputre"]
  s.email       = 'sharang.dashputre@weboniselab.com'
  s.files       = file_list
  s.license     = 'MIT'
end
