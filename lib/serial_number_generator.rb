class SerialNumberGenerator
  def self.generate
    String(Integer(Random.rand * (10 ** 20)))
  end
end