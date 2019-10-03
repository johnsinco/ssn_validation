module SsnValidation
  def self.config
    @@config ||= Configuration.new
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end

  class Configuration
    attr_accessor :test_ssns
    attr_accessor :enable_ascending

    def initialize
      @test_ssns = []
      @enable_ascending = false
    end
  end
end
