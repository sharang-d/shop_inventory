require_relative 'shop_inventory\shopkeeper'
require_relative 'shop_inventory\customer'


class ShopInventory

  def self.start
    
    customer = Customer.new
    shopkeeper = Shopkeeper.new

    STDOUT.sync = true
    print "Press 1 if you are the shopkeeper
    Anything else if you are a customer: "
    if(gets.strip == '1')
      loop do
        puts 'Enter 1 to add a new product'
        puts 'Enter 2 to delete a product'
        puts 'Enter 3 to list all products'
        puts 'Enter 4 to search a product'
        puts 'Enter 5 to edit a product entry'
        puts 'Enter 6 to quit'
        print 'Your choice: '
        choice = gets.to_i
        case choice
        when 1
          shopkeeper.add_product
        when 2
          shopkeeper.remove_product
        when 3
          puts shopkeeper.get_all_products
        when 4
          shopkeeper.search_product_by_name
        when 5
          puts shopkeeper.edit_product
        when 6
          break
        end
      end
    else
      loop do
        puts 'Enter 1 to list all products'
        puts 'Enter 2 to search a product'
        puts 'Enter 3 to buy a product'
        puts 'Enter 4 to quit'
        print 'Your choice: '
        choice = gets.to_i
        case choice
        when 1
          puts customer.get_all_products
        when 2
          customer.search_product_by_name
        when 3
          customer.buy_product
        when 4
          break
        end
      end
    end
  end
end
