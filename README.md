# RobotInDisguise

A ruby client for Intuit's Transformation Service -- also known as TFX.

## Installation

Add this line to your application's Gemfile:

    gem 'robot_in_disguise'

And then execute:

    $ bundle

(coming soon) Or install it yourself as:

    $ gem install robot_in_disguise
    
## Usage

1. Create a client
2. Do something

### The Client

Creating a new client is easy.

The following code will create a new client object without anything special added on.

```ruby
client = RobotInDisguise::Client.new
```

The client also supports being passed a block with additional configs. For example the client below:

```ruby
configured_client = RobotInDisguise::Client.new do |c|
  c.tfx_url = 'http://tfx.example.com'
  c.company_id = '12345'
end
```

Requests made by this `configured_client` will automatically go to `http://tfx.example.com` and will pass the company identifier header along to TFX.

### Search

Searching TFX is as simple as instantiating a client and calling it's `search` method.

When conducting a search the client will return an enumerable  `RobotInDisguise::SearchResults` object.

#### Simple

A basic search against TFX for "super cool invoices" might look like this:

```ruby
client = RobotInDisguise::Client.new
results = client.search('super cool invoices')
results.count # => 101
```

#### Not So Simple
Slightly more complicated searching is also possible.  

Using the code snippet below will search TFX for "super cool invoices" that meet the following criteria: 

- Returns only 5 results
- Uses `STSV2` as the primary datasource
- Uses `Inquira` as the secondary datasource
- Returns articles meant for the Windows version of Quickbooks (desktop)

We then print out the title of each `post` returned.

```ruby
client = RobotInDisguise::Client.new
search_options = {
  primary_ds: 'STSV2', 
  secondary_ds: 'InQuira', 
  pagesize: 5,
  product_name: 'QuickBooks', 
  product_platform: 'Windows'
}
results = client.search('super cool invoices', search_options)
results.count # => 5
results.each do |result|
  puts result.title
end
```

#### Note
`Posts` returned by `SearchResults` objects do not contain post `content`. TFX currently does not return the post content when searching.  In order to have `RobotInDisguise`  populate the `content` attribute of a `post` we need explicitly instantiate a `post` object.

### Post
Obtaining a `post` from TFX is also pretty straight forward -- just ask the client for the post.  You can ask using a `content_id` string, URI object or even a string URL.


```ruby
client = RobotInDisguise::Client.new
post = client.post('some_content:identifier')
post.title # => 'The post title'
# RobotInDisguise::Post works too
post_from_post = client.post(post)
post_from_post.title # => 'The post title'
# As do URI objects
post_uri = URI.parse('http://tfx/vX/search/posts/some_content:identifier')
post_from_ui = client.post('some_content:identifier')
post_from_ui.title # => 'The post title'
```

Post attributes and their values returned from TFX are automatically added to `Post` objects at the time of their instantiation.  A nice trick to see what attributes are available is using a posts's `attrs` ivar.  

For example:

```ruby
post.attrs.keys
# => [:data_source, :title, :titleslug, :description, :content, :extras, :answers, :_comment]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request
