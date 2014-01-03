require_relative 'productactions'
require 'fileutils'
require 'tempfile'

class Customer
	
  include ProductActions

  def buy_product
    print 'Enter the product id of the item that you want to buy: '
    id = gets.to_i
    if id_exists?(id)
      if in_stock?(id)
        puts 'in stock'
        print 'Enter you name: '
        name = gets.strip
        print 'Enter your Credit Card number: '
        cc_number = gets.strip
        print 'Enter the cvv number for your credit card: '
        cvv_number = gets.strip
        File.open('orders', 'a') do |file|
          file.puts "Customer name: #{name}"
          file.puts "Credit card number: #{cc_number}"
          file.puts "CVV number: #{cvv_number}"
          file.puts "Item id: #{id}"
        end
        temp_file = Tempfile.new('inventory_temp')
        File.open('inventory') do |file|
          until(file.eof?)
            line = file.readline
            temp_id = line.match(/^id: (.*)/)[1].to_i
            temp_file << line
            2.times { temp_file << file.readline }
            if temp_id == id
              temp_count = file.readline.match(/^count: (\d+)/)[1].to_i
              temp_file.puts "count: #{temp_count.pred}"
            else  
              temp_file << file.readline
            end
            temp_file << file.readline
          end
          temp_file.close
          FileUtils.mv(temp_file.path, 'inventory')
          puts 'Transaction is successful'
        end
      else
        puts 'Item is out of stock'
      end
    else
      puts 'Invalid product id'
    end
  end

  private
  def in_stock?(id)
    File.open('inventory') do |file|
      until(file.eof?)
        line = file.readline
        temp_id = line.match(/^id: (.*)/)[1]
        if temp_id.to_i == id
          2.times { file.readline }
          line = file.readline
          line.match(/^count: (.*)/)
          return $1.to_i > 0 ? true : false
        else
          4.times { file.readline }
        end
      end
    end 
  end

end