class Count
  @queue = :count

  class << self
    def perform args
      puts "result is #{args * 3}"
    end
  end
end
