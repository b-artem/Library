$LOAD_PATH << '.'

require 'yaml'
require 'library_utils.rb'
require 'book.rb'
require 'author.rb'
require 'reader.rb'
require 'order.rb'

class Library

  include LibraryUtils
  attr_accessor :books, :authors, :readers, :orders

  def initialize(books = nil, authors = nil, readers = nil, orders = nil)
    @books = books
    @authors = authors
    @readers = readers
    @orders = orders
  end

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

  def get_data(file)
    begin
      library = YAML.load_file(file)
    rescue
      puts "Couldn't open file #{file}"
      return
    end
    @books = library.books
    @authors = library.authors
    @readers = library.readers
    @orders = library.orders
  end

  def save_data(file)
    puts "Saving library data to file #{file}  ..."
    f = File.new(file, 'w')
    f.write(to_yaml)
    f.close
  rescue => exception
    puts "Couldn't save data to file. Exception: #{exception}"
  end

  def top(entity, top_amount = 1)
    return not_loaded unless loaded?
    return no_orders unless @orders
    if @orders[0].respond_to?(entity)
      groupped = @orders.group_by(&entity).sort_by { |_, val| -val.size }
      groupped.max_by(top_amount) { |_, val| val.size }.to_h.keys
    else
      puts "There is no such method #{entity} for Order instance"
    end
  end

  def top_books_readers(top_amount = 1)
    return not_loaded unless loaded?
    return no_orders unless @orders
    top_books = top(:book, top_amount)
    orders = @orders.select { |order| top_books.include? order.book }
    orders.map(&:reader).uniq.count
  end

end
