# wordpress-client

[![Gem Version](https://badge.fury.io/rb/wordpress-client.png)](https://rubygems.org/gems/wordpress-client) [![Build Status](https://travis-ci.org/dtaniwaki/wordpress-client.png)](https://travis-ci.org/dtaniwaki/wordpress-client)

wordpress-client is a [Wordpress Rest API Wrapper](http://developer.wordpress.com/docs/api/).

## Requirements

I test with ruby 1.9.3 and 2.1.0. Other versions/VMs are untested but might work fine.

## Installation

To your system

```ruby
gem install wordpress-client
```

Or add wordpress-client to your `Gemfile` and `bundle install`:

```ruby
gem 'wordpress-client'
```

## Usage

Create new client

```ruby
require 'wordpress-client'

# Shared client
client = Wordpress.client

# New client
client = Wordpress::Client.new
```

Call API without access token

```ruby
# Get posts of a specific domain without access token
posts = client.get_posts('wordpress-site-domain')
posts.each do |post|
  # Do something
end

# Get all the posts of a specific domain without access token
page = 1
loop do
  posts = client.get_posts('wordpress-site-domain', :page => page)
  posts.each do |post|
    # Do something
  end
  break if posts.size == 0
  page += 1
end
```

Call API with access token

```ruby
# Get user by access token
client.access_token = 'YOUR_ACCESS_TOKEN' # if you have any
user = client.me
site = user.site
posts = site.posts
```

## TODO
- Support create/update/delete from Wordpress::Object
- Add oauth method

## Contributing

See the [contributing guide](https://github.com/dtaniwaki/wordpress-client/blob/master/CONTRIBUTING.md).

## Copyright

Copyright (c) 2013-2013 Daisuke Taniwaki. See [LICENSE](https://github.com/dtaniwaki/wordpress-client/blob/master/LICENSE) for details.
