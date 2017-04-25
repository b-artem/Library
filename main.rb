$LOAD_PATH << '.'

require 'library.rb'

data_path = File.expand_path(File.dirname(__FILE__) + '/db')

############ For reading from TXT files (no need to use here) ############
# library.get_books_data(path + '/books.txt')
# library.get_readers_data(path + '/readers.txt')
# library.get_authors_data(path + '/authors.txt')

# library = Library.new
library = YAML.load_file(data_path + '/library_initial_data.yml')
library.generate_orders(50)

puts "Top reader(s) with corresponding number of orders: "
puts library.top(library.readers, 1)
puts "Top book(s) with corresponding number of orders: "
puts library.top(library.books, 1)
puts "Three most popular books: "
puts library.top(library.books, 3)
puts "How many people ordered one of the three most popular books: "
puts library.top_books_readers(3)

library.save_data(data_path + '/library_updated_data.yml')
