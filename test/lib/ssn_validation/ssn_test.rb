require 'minitest/autorun'
require 'ssn_validation/ssn'

class SsnTest < Minitest::Test
  include SsnValidation
  describe Ssn do
    describe 'valid formats' do
      describe 'valid ITIN' do
        it 'is valid' do
          assert_equal({}, Ssn.validate('911781111'))
        end
      end
      describe 'valid SSN' do
        it 'is valid' do
          assert_equal({}, Ssn.validate('123432100'))
        end
      end
      describe 'valid repeating SSN' do
        it 'is valid' do
          assert_equal({}, Ssn.validate('123444444'))
        end
      end
    end
    describe 'invalid formats' do
      describe '666 is invalid' do
        it 'is valid' do
          assert_equal({excluded_666: 'SSN value contains excluded area 666-xx-xxxx'}, Ssn.validate('666123210'))
        end
      end
      describe 'zero area numbers invalid' do
        it 'is invalid' do
          assert_equal({zero_area: 'SSN value contains zeros in area number 000-xx-xxxx'}, Ssn.validate('000567890'))
        end
      end
      describe 'zero group numbers invalid' do
        it 'is invalid' do
          assert_equal({zero_group: 'SSN value contains zeros in group number xxx-00-xxxx'}, Ssn.validate('567007890'))
        end
      end
      describe 'zero serial numbers invalid' do
        it 'is invalid' do
          assert_equal({zero_serial: 'SSN value contains zeros in serial number xxx-xx-0000'}, Ssn.validate('567890000'))
        end
      end
      describe 'non digits invalid' do
        it 'is invalid' do
          assert_equal({non_digits: 'SSN value contains non-digits'}, Ssn.validate('ABCDEFGHI'))
        end
      end
      describe 'not 9 digits invalid' do
        it 'is invalid' do
          assert_equal({nine_digits: 'SSN value is not 9 digits'}, Ssn.validate('303'))
        end
      end
     describe 'repeating digits invalid' do
        it 'is invalid' do
          assert_equal({repeating: 'SSN value contains repeating digits'}, Ssn.validate('888888888'))
        end
      end
      describe 'invalid ITIN' do
        it 'is invalid' do
          assert_equal({invalid_itin: 'SSN value contains invalid ITIN format 9xx-[x]x-xxxx'}, Ssn.validate('900991234'))
        end
      end
    end
    describe 'do extra validations based on probably bogus SSNSs' do
      before do
        SsnValidation.config.enable_ascending = true
      end
      describe 'ascending digits invalid' do
        it 'is invalid' do
          assert_equal({ascending: 'SSN value contains all ASCENDING digits'}, Ssn.validate('123456789'))
          assert_equal({ascending: 'SSN value contains all ASCENDING digits'}, Ssn.validate('567891234'))
        end
      end
      describe 'ascending digits ex 0 invalid' do
        it 'is invalid' do
          assert_equal({ascending: 'SSN value contains all ASCENDING digits'}, Ssn.validate('678912345'))
          assert_equal({ascending: 'SSN value contains all ASCENDING digits'}, Ssn.validate('123456789'))
          assert_equal({ascending: 'SSN value contains all ASCENDING digits'}, Ssn.validate('234567891'))
        end
      end
      describe 'descending digits invalid' do
        it 'is invalid' do
          assert_equal({descending: 'SSN value contains all DESCENDING digits'}, Ssn.validate('876543210'))
          assert_equal({descending: 'SSN value contains all DESCENDING digits'}, Ssn.validate('321098765'))
          assert_equal({descending: 'SSN value contains all DESCENDING digits'}, Ssn.validate('765432109'))
        end
      end
      describe 'descending digits ex 0 invalid' do
        it 'is invalid' do
          assert_equal({descending: 'SSN value contains all DESCENDING digits'}, Ssn.validate('321987654'))
          assert_equal({descending: 'SSN value contains all DESCENDING digits'}, Ssn.validate('765432198'))
        end
      end
    end
    describe 'allowing dummy ssns' do
      it 'allows 666xxxxx' do
        SsnValidation.config.test_ssns = [/^666/]
        assert_equal({}, Ssn.validate('666123456'))
        SsnValidation.config.test_ssns = []
      end
      it 'allows random test ssns' do
        SsnValidation.config.test_ssns = ['509421234']
        assert_equal({}, Ssn.validate('509421234'))
        SsnValidation.config.test_ssns = []
      end
      it 'allows multiple test ssns' do
        SsnValidation.config.test_ssns = ['999999999', /^666/]
        assert_equal({}, Ssn.validate('666123456'))
        assert_equal({}, Ssn.validate('999999999'))
        SsnValidation.config.test_ssns = []
      end
    end
  end
end
