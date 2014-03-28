# Coban

Ruby protocol parser for coban trackers

## Installation

Add this line to your application's Gemfile:

  gem 'coban'

And then execute:

  $ bundle

Or install it yourself as:

  $ gem install coban

## Usage

  Login message:
  ```ruby
  require 'coban'
  response = Coban::TK103B.parse('##,imei:359710041775538,A;')
  # { imei: '359710041775538', type: :logon, response: 'LOAD' }
  ```

  Heartbeat:
  ```ruby
  require 'coban'
  response = Coban::TK103B.parse('359710041775538')
  # { imei: '359710041775538', type: :heartbeat, response: 'ON' }
  ```  

## Contributing

1. Fork it ( http://github.com/diegobernardes/coban/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
