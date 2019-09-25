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

    def initialize
      @test_ssns = []
    end
  end
end
