module ActiveModel
  module Validations
    class SocialSecurityNumberValidator < EachValidator
      def validate_each(record, attribute, value)
        ssn_errors = Ssn.validate(value)
        return if ssn_errors.blank?
        ssn_errors.values.each {|error| record.errors[attribute] << error}
      end
    end
  end
end


