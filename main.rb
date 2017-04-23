$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'library.rb'

library = Library.new('Foreign Literature')
path = File.expand_path(File.dirname(__FILE__) + '/db')

library.get_books_data(path + '/books.txt')
library.get_readers_data(path + '/readers.txt')
library.get_authors_data(path + '/authors.txt')
# library.get_data(path + '/library_saved.yml')

library.generate_orders(100)

puts library.top_reader
puts library.top_books(3)

library.save_data(path + '/library_saved.yml')
