require 'minitest/autorun'
require 'ssn_validation'
require 'activemodel'

class SsnTestModel
  include ActiveModel::Validations
  attr_accessor :ssn
  validates :ssn, social_security_number: true
end

class SocialSecurityNumberValidatorTest < Minitest::Test
  describe 'it uses the ssn validation rules' do
    it 'validates' do
      subject = SsnTestModel.new(ssn: '666000000')
      assert_equal({}, subject.errors)
    end
  end
end
