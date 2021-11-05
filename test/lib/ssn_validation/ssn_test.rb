require 'minitest/autorun'
require 'ssn_validation'

class SsnTest < Minitest::Test
  include SsnValidation
  describe Ssn do
    describe 'valid formats' do
      describe 'valid ITIN' do
        it 'is valid' do
          _(Ssn.validate('911781111')).must_equal({})
          _(Ssn.validate('911501111')).must_equal({})
          _(Ssn.validate('911651111')).must_equal({})
          _(Ssn.validate('911651111')).must_equal({})
          _(Ssn.validate('911881111')).must_equal({})
          _(Ssn.validate('911901111')).must_equal({})
          _(Ssn.validate('911991111')).must_equal({})
        end
      end
      describe 'valid SSN' do
        it 'is valid' do
          _(Ssn.validate('123432100')).must_equal({})
        end
      end
      describe 'valid repeating SSN' do
        it 'is valid' do
          _(Ssn.validate('123444444')).must_equal({})
        end
      end
      describe 'valid with dashes' do
        it 'ignores the dashes' do
          _(Ssn.validate('123-44-4444')).must_equal({})
        end
      end
    end
    describe 'invalid formats' do
      describe '666 is invalid' do
        it 'is valid' do
          _(Ssn.validate('666123210')).must_equal({excluded_666: 'SSN value contains excluded area 666-xx-xxxx'})
        end
      end
      describe 'zero area numbers invalid' do
        it 'is invalid' do
          _(Ssn.validate('000567890')).must_equal({zero_area: 'SSN value contains zeros in area number 000-xx-xxxx'})
        end
      end
      describe 'zero group numbers invalid' do
        it 'is invalid' do
          _(Ssn.validate('567007890')).must_equal({zero_group: 'SSN value contains zeros in group number xxx-00-xxxx'})
        end
      end
      describe 'zero serial numbers invalid' do
        it 'is invalid' do
          _(Ssn.validate('567890000')).must_equal({zero_serial: 'SSN value contains zeros in serial number xxx-xx-0000'})
        end
      end
      describe 'non digits invalid' do
        it 'is invalid' do
          _(Ssn.validate('ABCDEFGHI')).must_equal({non_digits: 'SSN value contains non-digits'})
        end
      end
      describe 'not 9 digits invalid' do
        it 'is invalid' do
          _(Ssn.validate('303')).must_equal({nine_digits: 'SSN value is not 9 digits'})
        end
      end
      describe 'repeating digits invalid' do
        it 'is invalid' do
          _(Ssn.validate('888888888')).must_equal({repeating: 'SSN value contains repeating digits'})
        end
      end
      describe 'invalid ITIN' do
        it 'is invalid' do
          _(Ssn.validate('900121234')).must_equal({invalid_itin: 'SSN value contains invalid ITIN format 9xx-[x]x-xxxx'})
          _(Ssn.validate('900441234')).must_equal({invalid_itin: 'SSN value contains invalid ITIN format 9xx-[x]x-xxxx'})
        end
      end
    end
    describe 'do extra validations based on probably bogus SSNSs' do
      before do
        SsnValidation.config.enable_ascending = true
      end
      describe 'ascending digits invalid' do
        it 'is invalid' do
          _(Ssn.validate('123456789')).must_equal({ascending: 'SSN value contains all ASCENDING digits'})
          _(Ssn.validate('567891234')).must_equal({ascending: 'SSN value contains all ASCENDING digits'})
        end
      end
      describe 'ascending digits ex 0 invalid' do
        it 'is invalid' do
          _(Ssn.validate('678912345')).must_equal({ascending: 'SSN value contains all ASCENDING digits'})
          _(Ssn.validate('123456789')).must_equal({ascending: 'SSN value contains all ASCENDING digits'})
          _(Ssn.validate('234567891')).must_equal({ascending: 'SSN value contains all ASCENDING digits'})
        end
      end
      describe 'descending digits invalid' do
        it 'is invalid' do
          _(Ssn.validate('876543210')).must_equal({descending: 'SSN value contains all DESCENDING digits'})
          _(Ssn.validate('321098765')).must_equal({descending: 'SSN value contains all DESCENDING digits'})
          _(Ssn.validate('765432109')).must_equal({descending: 'SSN value contains all DESCENDING digits'})
        end
      end
      describe 'descending digits ex 0 invalid' do
        it 'is invalid' do
          _(Ssn.validate('321987654')).must_equal({descending: 'SSN value contains all DESCENDING digits'})
          _(Ssn.validate('765432198')).must_equal({descending: 'SSN value contains all DESCENDING digits'})
        end
      end
    end
    describe 'allowing dummy ssns' do
      it 'allows 666xxxxx' do
        SsnValidation.config.test_ssns = [/^666/]
        _(Ssn.validate('666123456')).must_equal({})
        SsnValidation.config.test_ssns = []
      end
      it 'allows random test ssns' do
        SsnValidation.config.test_ssns = ['509421234']
        _(Ssn.validate('509421234')).must_equal({})
        SsnValidation.config.test_ssns = []
      end
      it 'allows multiple test ssns' do
        SsnValidation.config.test_ssns = ['999999999', /^666/]
        _(Ssn.validate('666123456')).must_equal({})
        _(Ssn.validate('999999999')).must_equal({})
        SsnValidation.config.test_ssns = []
      end
    end
  end
end
