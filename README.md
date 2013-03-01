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

Here is how to include it as a partial. In all three cases, {{foo}} will evaluate to 'bar':
```ruby
render :partial => "something", :locals => {:foo => 'bar'} # Read from local variables
render :partial => "something", :locals => {:mustache => {:foo => "bar"}} # Read from a Hash
render :partial => "something", :locals => {:mustache => OpenStruct.new(:foo => "bar")} # Read from an object
```
