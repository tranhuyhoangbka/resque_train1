class CountFrequency
  @queue = :count_frequency

  def self.perform
    Resque.enqueue Count, 5
  end
end
