require 'minitest/autorun'
require 'ssn_validation'

class SsnTest < Minitest::Test
  describe 'shortcut validator' do
    it 'validates' do
      assert_equal({}, SsnValidation.validate('123432100'))
    end
  end
end
