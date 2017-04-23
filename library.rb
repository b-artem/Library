require 'yaml'

class Book
  attr_reader :title, :author
  def initialize(title, author)
    @title = title
    @author = author
  end
end

class Order
  attr_reader :book, :reader, :date
  def initialize(book, reader, date)
    @book = book
    @reader = reader
    @date = date
  end
end

class Reader
  attr_reader :name, :email, :city, :street, :house
  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end
end

class Author
  attr_reader :name, :biography
  def initialize(name, biography)
    @name = name
    @biography = biography
  end
end

class Library

  def initialize(name)
    @name = name
  end

  def loaded?
    @books && @authors && @readers
  end

  def not_loaded
    puts 'You should load library data using get_data(file) method before
      using any other methods'
  end

  def get_data(file)
    puts "Reading library data from file #{file}"
    @books = YAML.load_file(file)
  end

  def save_data(file)
    puts "Saving library data to file #{file}  ..."
    f = File.new(file, 'w')
    f.write(to_yaml)
    f.close
  end

  def generate_orders(orders_amount)
    if loaded?
      @orders = []
      orders_amount.times do
        book_index = rand(0...@books.count)
        reader_index = rand(0...@readers.count)
        date = Date.today - rand(1..30)
        @orders << Order.new(@books[book_index].title, @readers[reader_index].name, date)
      end
      puts "Generating #{orders_amount} orders..."
    else
      not_loaded
    end
  end

  def top_reader
    if @orders
      readers = Hash.new(0)
      @orders.each { |order| readers[order.reader] += 1 }
      max = readers.values.max
      readers.select { |_, value| value == max }
    else
      puts "There is no orders in the library yet. You may create them using
            generate_orders(orders_amount) method"
    end
  end

  def top_books(top_amount = 1)
    if @books
      books = Hash.new(0)
      top_books = Hash.new(0)
      @orders.each { |order| books[order.book] += 1 }
      top_amount.times do
        max = books.values.max
        top_books.merge!(books.select { |_, value| value == max })
        books.delete_if { |_, value| value == max }
      end
      top_books
    else
      puts "There is no orders in the library yet. You may create them using
      generate_orders(orders_amount) method"
    end
  end

  def top_books_readers(top_amount = 1)
    if loaded?
      readers = []
      top_books(top_amount).each_key do |key|
        (readers << key) unless readers.include?(key)
      end
      readers
    else
      not_loaded
    end
  end

  # Utils for reading data from TXT files ######################################
  def get_books_data(file)
    @books = []
    f = File.open(file)
    f.each do |line|
      params = line.split(',').map(&:strip)
      @books << Book.new(params[0], params[1])
    end
    f.close
  end

  def get_readers_data(file)
    @readers = []
    f = File.open(file)
    f.each do |line|
      params = line.split(',').map(&:strip)
      @readers << Reader.new(params[0], params[1], params[2], params[3], params[4])
    end
    f.close
  end

  def get_authors_data(file)
    @authors = []
    f = File.open(file)
    f.each do |line|
      params = line.split(',').map(&:strip)
      @authors << Author.new(params[1], params[0])
    end
    f.close
  end
  ###########################################################################

end
