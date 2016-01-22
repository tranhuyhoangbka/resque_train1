class Count
  @queue = :count

  class << self
    def perform args
      puts "result is #{args * 3}\n"
    end
  end
end
