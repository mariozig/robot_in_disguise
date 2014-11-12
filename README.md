# RobotInDisguise

A ruby client for Intuit's Transformation Service -- also known as TFX.

## Installation

Add this line to your application's Gemfile:

    gem 'robot_in_disguise'

And then execute:

    $ bundle

<!-- Or install it yourself as:

    $ gem install robot_in_disguise
 -->
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

Requests made by this `configured_client` will automatically go to `http://tfx.example.com` and will pass a company identifier header parameter along.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request
