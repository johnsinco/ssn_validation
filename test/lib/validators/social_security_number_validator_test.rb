require 'minitest/autorun'
require 'active_model'
require 'ssn_validation'
require 'validators/social_security_number_validator'

class SsnTestModel
  include ActiveModel::Validations
  attr_accessor :ssn
  validates :ssn, social_security_number: true
end

class SocialSecurityNumberValidatorTest < Minitest::Test
  describe 'it uses the ssn validation rules' do
    it 'validates' do
      subject = SsnTestModel.new
      subject.ssn = '123454321'
      assert subject.valid?
      assert_equal({}, subject.errors.to_h)
    end

    it 'can use the ascending validation rules' do
      SsnValidation.config.enable_ascending = true
      subject = SsnTestModel.new
      subject.ssn = '123456789'
      subject.valid?
      assert_equal({ssn: 'SSN value contains all ASCENDING digits'}, subject.errors.to_h)
      SsnValidation.config.enable_ascending = false 
    end
  end
end
