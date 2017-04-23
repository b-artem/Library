$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'library.rb'

puts 'Begin...'

library = Library.new('Foreign Literature')
path = File.expand_path(File.dirname(__FILE__) + '/db')

library.get_books_data(path + '/books.txt')
library.get_readers_data(path + '/readers.txt')
library.get_authors_data(path + '/authors.txt')

library.generate_orders(20)

library.top_reader

library.save_data(path + '/library_saved.yml')

puts 'End'
