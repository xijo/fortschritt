# Fortschritt

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fortschritt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fortschritt

## Usage

Start a progress bar by calling `with_fortschritt` on an `Enumerable` or an `ActiveRecord::Relation`.

It will create a new progress bar, that will be incremented by calling `Fortschritt.increment`.

However, for convenience you can call `#fortschritt` on your iterated objects as well. It will call `Fortschritt.increment` and return `self`, so you can chain it up nicely.

```ruby
User.all.with_fortschritt.find_each do |user|
  user.fortschritt.valid?
end

# will print something like this: 1616/145096 → 00:13:21 → ETA 2016-02-04 18:11:50
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xijo/fortschritt.

