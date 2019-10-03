# SsnValidation

SsnValidation is a very basic ruby gem that can validate a US Social Security Number (SSN) or ITIN.  It returns a hash of error keys/messages that can be 
used within ActiveRecord errors or otherwise to ensure syntactically valid SSNs.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ssn_validation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ssn_validation

## Usage

```
❯ irb
> require 'ssn_validation'
> SsnValidation::Ssn.validate('abc')
=> {:nine_digits=>"SSN value is not 9 digits", :non_digits=>"SSN value contains non-digits"}
> SsnValidation::Ssn.validate(123006789)
=> {:zero_group=>"SSN value contains zeros in group number xxx-00-xxxx"}
> SsnValidation::Ssn.validate(nil)
=> {:nine_digits=>"SSN value is not 9 digits"}
> SsnValidation::Ssn.validate('')
=> {:nine_digits=>"SSN value is not 9 digits"}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johnsinco/ssn_validation

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
