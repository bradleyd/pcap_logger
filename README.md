# PcapLogger

Sniffs local traffic from an interface and sends raw packets to a remote socket ( EM server) for logging.

* I use this for capturing sip traffic and storing the sip sessions in pcap files for later viewing.

## Installation

Add this line to your application's Gemfile:

    gem 'pcap_logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pcap_logger

## Usage

If you are using rvm, you have to use `rvmsudo` to peek in on device
There is also the assumption that you have a socket server somewhere for this to connect to and write raw packets.

```ruby
rvmsudo bin/pcap_logger -s 1500 -c 10 -f "port 80" -rp 20000 -rh '127.0.0.1'
```

##NOTE:
  There must be a socket server listening on a port somewhere

##TODO:
  * need to give the option to change the socket server host and port from a config file or cli


* NOTE: this must be run as root to access your local interfaces


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
