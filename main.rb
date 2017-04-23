$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'library.rb'

path = File.expand_path(File.dirname(__FILE__) + '/db')

############ For reading from TXT files (no need to use here) ############
# library.get_books_data(path + '/books.txt')
# library.get_readers_data(path + '/readers.txt')
# library.get_authors_data(path + '/authors.txt')

# library = Library.new
library = YAML.load_file(path + '/library_initial_data.yml')
library.generate_orders(50)

puts "Top reader(s) with corresponding number of orders: "
puts library.top_reader
puts "Top book(s) with corresponding number of orders: "
puts library.top_books(1)
puts "Three most popular books: "
puts library.top_books(3)
puts "How many people ordered one of the three most popular books: "
puts library.top_books_readers(3)

library.save_data(path + '/library_updated_data.yml')
