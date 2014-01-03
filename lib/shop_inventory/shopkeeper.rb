require_relative 'product'
require_relative 'productactions'

class Shopkeeper

  include ProductActions

  def add_product
    puts 'Enter details of for the product that you want to add'
    print 'Name: '
    name = gets.strip
    print 'Price: '
    price = gets.strip 
    print 'No. of items in stock: '
    count = gets.strip
    print 'Manufacturer: '
    company = gets.strip
    Product.add_product(name, price, count, company)
  end

  def remove_product
    print 'Enter product id of the product that you wish to remove: '
    id = gets.to_i
    if !id_exists?(id)
      puts 'Product does not exist'
      return
    end
    Product.remove_product(id)
    puts 'Success' 
  end

  def edit_product
    print 'Enter id of the product that you wish to edit: '
    id = gets.to_i
    if result = Product.get_product_by_id(id)
      puts "Old entry: #{result}"
      puts "Enter new details: "
      print 'Name: '
      name = gets.strip
      print 'Price: '
      price = gets.strip 
      print 'No. of items in stock: '
      count = gets.strip
      print 'Manufacturer: '
      company = gets.strip
      Product.remove_product(id)
      Product.add_product(name, price, count, company, id)
      "Success"
    else
      "Invalid Product Id"
    end
  end

end