# Musterb

This is a gem that lets you compile mustache to erb so that rails will do all the nice caching and such that it does for ERB.

## Installation

Add this line to your application's Gemfile:

    gem 'musterb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install musterb

## Usage

Add this into config/initializers/musterb_handler.rb
```ruby
require 'musterb/template_handler'

ActionView::Template.register_template_handler :mustache, Musterb::TemplateHandler
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
