require 'ssn_validation/ssn_validation'
require 'ssn_validation/ssn'

# optional ActiveModel dependency for custom validator
begin
  require 'validators/social_security_number_validator'
rescue 
  nil
end
