# Observer

Implement observer pattern in Ruby

[![Build Status](https://travis-ci.org/simlegate/observer.png?branch=master)](https://travis-ci.org/simlegate/observer)  [![Code Climate](https://codeclimate.com/github/simlegate/observer.png)](https://codeclimate.com/github/simlegate/observer)

## Installation

Add this line to your application's Gemfile:

    gem 'observer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install observer

## Usage

Define a abservable

    class Publish
      include Observable

      # coding other
    end


Define a observer, you only implement a method named update in your observer class
   
    class Subscribe
      def update publish, msg
        # coding after observable changed
	p "receive message: #{msg}"
      end
    end

Add observer

    publish   = Publish.new
    subscribe = Subscribe.new
    observers = publish.add_observer(subscribe)

Observable changed

    publish.changed
    publish.notify_observers(self, "publish have changed!")

Observers receive notify from observalbe , update in Subscribe Class will be called.  
    
    # => receive message: publish have changed!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
