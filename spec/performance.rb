require 'bundler/setup'
require 'benchmark'

require 'musterb'
require 'mustache'
require 'erubis'

template = <<-EOF
{{#products}}
<div class="product-item" data-variant-id='{{id}}' data-favorite-id='{{favorite_id}}' data-quick-view-url="{{quick_view_url}}">
    <h3>Product: {{name}}</h3>

    <a href="{{url}}" class="quickView">
        <img src="{{thumbnail}}"/>
    </a>
    <ul>
        <li>SKU: {{sku}}</li>
        <li>Fabrics: {{fabrics}}</li>
        <li>Themes: {{themes}}</li>
        <li>Price: {{price}}</li>
        <li>Designer: {{designer}}
        <li class="favorite">
          <div class="not-favorited {{favorited}}">
            <button class="add-to-favorites">Add to Favorite</button>
          </div>
          <div class="favorited  {{favorited}}">
            <button class="remove-from-favorites">Remove from Favorite</button>
          </div>
        </li>
    </ul>
</div>
{{/products}}
EOF

def random_product
  {
    "id" => rand(10000),
    "favorite_id" => rand(10000),
    "quick_view_url" => "http://foo.bar",
    "name" => "Product name",
    "url" => "http://foo.url",
    "thumbnail" => "http://foo.image",
    "sku" => "sku",
    "fabrics" => "fabrics",
    "themes" => "themes",
    "designer" => "designer",
    "favorited" => "favorited"
  }
end

products = 16.times.map { random_product }

mustache = lambda { Mustache.render(template, :products => products) }

erb = Musterb.to_erb(template)
compiled_erb = Erubis::Eruby.new(erb)
musterb = lambda { compiled_erb.result(:products => products) }

if mustache.call == musterb.call
  puts "mustache and musterb are identical"
else
  puts "mustache and musterb differ (this will usually be whitespace)"
  puts "mustache:"
  puts mustache.call
  puts "--------------------------------------------------------------------------------"
  puts "musterb:"
  puts musterb.call
  puts "--------------------------------------------------------------------------------"
end

Benchmark.bmbm do |x|
  x.report("mustache") { 1000.times { mustache.call } }
  x.report("musterb") { 1000.times { musterb.call } }
end
