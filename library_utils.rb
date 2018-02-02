module LibraryUtils

  def generate_orders(orders_amount)
    return not_loaded unless loaded?
    puts "Generating #{orders_amount} random orders..."
    @orders = []
    orders_amount.times do
      book_index = rand(0...@books.count)
      reader_index = rand(0...@readers.count)
      date = Date.today - rand(1..30)
      @orders << Order.new(@books[book_index].title, @readers[reader_index].name, date)
    end
  end

end
