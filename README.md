# wordpress-client

wordpress-client is a [Wordpress Rest API Wrapper](http://developer.wordpress.com/docs/api/).

## Getting started

Add wordpress-client to your `Gemfile` and `bundle install`:

```ruby
gem 'wordpress-client'
```

## Usage

```ruby
require 'wordpress-client'

# Get user by access token
client = Wordpress.client
client.access_token = 'YOUR_ACCESS_TOKEN' # if you have any
user = client.me
site = user.site
posts = site.posts

# Get posts of a specific domain without access token
client = Wordpress::Client.new
posts = client.get_posts('wordpress-site-domain')
posts.each do |post|
  # Do something
end

# Get all the posts of a specific domain without access token
client = Wordpress::Client.new
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

## TODO
- Complete spec test
- Support all the apis
- Support create/update/delete from Wordpress::Object
- Add oauth method

## Contributing

See the [contributing guide](https://github.com/dtaniwaki/wordpress-client/blob/master/CONTRIBUTING.md).

## Copyright

Copyright (c) 2010-2013 Daisuke Taniwaki. See LICENSE for details.
