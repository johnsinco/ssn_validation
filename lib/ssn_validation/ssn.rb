module SsnValidation
  module Ssn
    DIGITS     = %w[0 1 2 3 4 5 6 7 8 9].freeze
    DIGITS_EX0 = DIGITS[1..-1]

    # returns a hash of 0..n key/value pairs for ssn validation error codes and a default message for each
    def self.validate(ssn)
      ssn    = ssn.to_s
      errors = {}
      return errors if test_ssn?(ssn)

      (ssn.length != 9) && errors[:nine_digits]        = "SSN value is not 9 digits"
      (ssn.chars - DIGITS).any? && errors[:non_digits] = "SSN value contains non-digits"
      return errors if errors.any?  # return if basic conditions fail

      (ssn[0..2] == "666") && errors[:excluded_666]       = "SSN value contains excluded area 666-xx-xxxx"
      (ssn.chars - [ssn[0]]).empty? && errors[:repeating] = "SSN value contains repeating digits"
      (ssn[0..2] == "000") && errors[:zero_area]          = "SSN value contains zeros in area number 000-xx-xxxx"
      (ssn[3..4] == "00") && errors[:zero_group]          = "SSN value contains zeros in group number xxx-00-xxxx"
      (ssn[5..8] == "0000") && errors[:zero_serial]       = "SSN value contains zeros in serial number xxx-xx-0000"
      ascending?(ssn) && errors[:ascending]               = "SSN value contains all ASCENDING digits"
      descending?(ssn) && errors[:descending]             = "SSN value contains all DESCENDING digits"
      return errors if errors.any?  # return if ssn conditions fail

      # check valid ITIN format last
      invalid_itin?(ssn) && errors[:invalid_itin] = "SSN value contains invalid ITIN format 9xx-[x]x-xxxx"
      errors
    end

    def self.ascending?(ssn)
      return true if ssn.chars == DIGITS.rotate(ssn[0].to_i)[0..8]
      return true if ssn.chars == DIGITS_EX0.rotate(ssn[0].to_i - 1)

      false
    end

    def self.descending?(ssn)
      return true if ssn.chars == DIGITS.reverse.rotate(-(ssn[0].to_i + 1))[0..8]
      return true if ssn.chars == DIGITS_EX0.reverse.rotate(-ssn[0].to_i)

      false
    end

    def self.invalid_itin?(ssn)
      ssn[0] == "9" && !%w[7 8].include?(ssn[3])
    end

    def self.test_ssn?(ssn)
      SsnValidation.config.test_ssns.any? {|p| p.match(ssn)}
    end
  end

  def self.validate(ssn)
    Ssn.validate(ssn)
  end
end
