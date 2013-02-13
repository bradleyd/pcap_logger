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


* NOTE: this must be run as root to access your local interfaces


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
