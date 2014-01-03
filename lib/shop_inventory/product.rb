require 'fileutils'
require 'tempfile'

class Product

  def self.add_product(name, price, count, company, id = nil)
    id = id ? id : get_max_id.succ
    File.open('inventory', 'a') do |file|
      file.puts "id: #{id}"
      file.puts "name: #{name}"
      file.puts "price: #{price}"
      file.puts "count: #{count}"
      file.puts "company: #{company}"
    end
  end
  
  def self.remove_product(id)
    return if !File.exists?('inventory')
    flag = false
    temp = Tempfile.new('inventory_temp')
    File.open('inventory', 'r') do |file|
      until(file.eof?)
        line = file.readline
        line.match(/^id: (.*)/)
        temp_id = $1.to_i
        if temp_id != id
          temp << line
          temp << file.readline
          temp << file.readline
          temp << file.readline
          temp << file.readline
          flag = true
        else
          4.times { file.readline }
        end
      end
    end
    temp.close
    if flag
      FileUtils.mv(temp.path, 'inventory')
    else
      temp.unlink
    end
  end

  def self.get_product_by_id(id)
    return nil if !File.exists?('inventory')
    result = ''
    File.open('inventory', 'r') do |file|
      until(file.eof?)
        line = file.readline
        temp_id = line.match(/^id: (.*)/)[1]
        if temp_id.to_i == id
          4.times { result << file.readline }
          break
        else
          4.times { file.readline }
        end
      end
    end 
    result == '' ? nil : result
  end

  private
  def self.get_max_id
    max = 0
    return max if !File.exists?('inventory')
    File.open('inventory', 'r') do |file|
      until(file.eof?)
        line = file.readline
        temp_id = line.match(/^id: (.*)/)[1].to_i
        max = temp_id if temp_id > max
        4.times { file.readline }
      end
    end
    max
  end

end