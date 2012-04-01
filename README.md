# tasty

Ruby gem for interacting with the [del.icio.us API](http://www.delicious.com/help/api/)

## Requirements

* HTTParty
* FakeWeb (testing)

## Install

`gem install tasty`

## Example

```ruby
>> require 'tasty'
=> true
>> tasty = Tasty.new('delicious_username', 'delicious_password')
=> #<Tasty:0x101868d80 @delicious_api_url="https://api.del.icio.us/v1/", @password="delicious_password", @username="delicious_username">
```

## Changelog

### 1.0.1

* Added set_timeout method to set timeout for HTTP requests

## Contributing to tasty
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2010-2012 David Czarnecki. See LICENSE.txt for further details.