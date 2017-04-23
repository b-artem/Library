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

    def get_data(file)
      @books = YAML.load_file(file)
      # puts "#{@books[9].title}, #{@books[9].author}"
    end

    def save_data(file)
      puts 'Saving library data to file...'
      f = File.new(file, 'w')
      f.write(self.to_yaml)
      f.close
      puts 'File closed?: ' + "#{f.closed?}"
    end

    def generate_orders(orders_amount)
      @orders = []
      prng = Random.new
      orders_amount.times do
        book_index = prng.rand(0...@books.count)
        reader_index = prng.rand(0...@readers.count)
        date = Date.today - prng.rand(1..30)
        @orders << Order.new(@books[book_index].title, @readers[reader_index].name, date)
      end
    end

    def top_reader
      if @orders
        readers = Hash.new(0)
        @orders.each { |order| readers[order.reader] += 1 }
        max = readers.values.max
        top_reader = readers.select { |_, value| value == max }
        puts "Top reader(s): #{top_reader}"
      else
        puts "There is no orders in the library yet. You may create them using
              generate_orders(orders_amount) function"
      end
    end

############################################################################
    def get_books_data(file)
      @books = []
      f = File.open(file)
      f.each do |line|
        params = line.split(',').map(&:strip)
        @books << Book.new(params[0], params[1])
      end
      f.close
      @books.each { |book| puts "#{book.title}, #{book.author}" }
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

#############################################################################

  end
