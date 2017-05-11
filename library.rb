$LOAD_PATH << '.'

require 'yaml'
require 'book.rb'
require 'author.rb'
require 'reader.rb'
require 'order.rb'
require 'library_utils.rb'

class Library

  include LibraryUtils
  attr_reader :books, :authors, :readers, :orders

  # def initialize(name)
  #   @name = name
  # end

  def loaded?
    @books && @authors && @readers
  end

  def not_loaded
    puts 'You should load library data using get_data(file) method before
    using any other methods'
    exit
  end

  def no_orders
    puts "There are no orders in the library yet. You may create them using
    generate_orders(orders_amount) method"
    exit
  end

  def self.get_data(file)
    YAML.load_file(file)
  end

  def save_data(file)
    puts "Saving library data to file #{file}  ..."
    f = File.new(file, 'w')
    f.write(to_yaml)
    f.close
  end

  def top(entity, top_amount = 1)
    return not_loaded unless loaded?
    return no_orders unless @orders
    if @orders[0].respond_to?(entity)
      obj_hash = Hash.new(0)
      @orders.each { |order| obj_hash[order.public_send(entity)] += 1 }
      maxs = obj_hash.values.uniq.max(top_amount)
      top = obj_hash.select { |_, v| maxs.include?(v) }
      top.sort_by { |_, v| -v }.to_h
    else
      puts "There is no such method #{entity} for Order instance"
    end
  end

  def top_books_readers(top_amount = 1)
    return not_loaded unless loaded?
    return no_orders unless @orders
    readers = []
    top_books = top(@books, top_amount).keys
    @orders.each do |order|
      if top_books.include?(order.book) && !readers.include?(order.reader)
        readers << order.reader
      end
    end
    readers.count
  end

end
