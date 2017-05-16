require './library.rb'

data_path = './db/'
library = Library.new
library.get_data(data_path + 'library_initial_data.yml')
library.generate_orders(50)
library.save_data(data_path + 'library_updated_data.yml')

print "Top reader(s): "
puts library.top(:reader, 1)
print "Top book(s): "
puts library.top(:book, 1)
print "Three most popular books: "
p library.top(:book, 3)
print "How many people ordered one of the three most popular books: "
puts library.top_books_readers(3)
