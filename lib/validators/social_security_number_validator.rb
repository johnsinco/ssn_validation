require 'active_model'
require 'ssn_validation/ssn'

module ActiveModel
  module Validations
    class SocialSecurityNumberValidator < EachValidator
      def validate_each(record, attribute, value)
        ssn_errors = SsnValidation::Ssn.validate(value)
        return if ssn_errors.blank?
        ssn_errors.values.each { |error| record.errors.add(attribute, error) }
      end
    end
  end
end


