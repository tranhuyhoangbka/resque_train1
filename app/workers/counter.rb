class Counter
  @queue = :counter

  def self.perform
    puts "Now is #{Time.now} \n"
  end
end
