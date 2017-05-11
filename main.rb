require './library.rb'

data_path = './db'
library = Library.new
library = Library.get_data(data_path + '/library_initial_data.yml')
library.generate_orders(50)

puts "Top reader(s) with corresponding number of orders: "
puts library.top(:reader, 1)
puts "Top book(s) with corresponding number of orders: "
puts library.top(:book, 1)
puts "Three most popular books: "
puts library.top(:book, 3)
puts "How many people ordered one of the three most popular books: "
puts library.top_books_readers(3)

library.save_data(data_path + '/library_updated_data.yml')
