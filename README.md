# DomainCheck

DomainCheck is a simple tool written in Ruby that checks the availability of
domain names using combinations of keywords defined by the user.  Based on
the lists of prefixes, suffixes, and top-level domains (TLDs) it's given,
it can (semi-)rapidly find combinations of these that are unoccupied or
display basic summary information about the domain registration.


## Installation

Add this line to your application's Gemfile:

    gem 'domain_check'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install domain_check

## Usage

The `domain_check` executable is located in the `bin/` directory and can be
invoked in three ways:

### 1. Single domain check

Check the availability of a single domain by passing the `-d` or `--domain`:

```bash
$ bin/domain_check -d google.com
google.com               REGISTERED, contact: Dns Admin, email: dns-admin@google.com, since: 1997-09-15, expires: 2020-09-13

### 2. Multiple domain check

Check the availability of a multiple domains formed by combining keywords and
top-level domains using three arguments:

```bash
$ bin/domain_check -p super,mega -s corp,plex -t com,net
supercorp.com            REGISTERED, since: 2002-05-09, expires: 2014-05-09
supercorp.net            AVAILABLE
superplex.com            REGISTERED, since: 2003-01-11, expires: 2016-01-11
superplex.net            REGISTERED, since: 2005-05-01, expires: 2015-05-01
megacorp.com             REGISTERED, since: 1997-12-30, expires: 2013-12-29
megacorp.net             REGISTERED, contact: Misunderstood Computer God, since: 1998-06-04, expires: 2013-06-03
megaplex.com             REGISTERED, since: 1995-08-19, expires: 2014-08-18
megaplex.net             REGISTERED, since: 1999-02-15, expires: 2014-02-15

### 3. Pass a YAML file

It's also possible to create a YAML file with lists of keywords and TLDs that
will be read and parsed by the application via the `-f` or `--file` option.

```ruby
prefixes:
  - super
  - mega
suffixes:
  - corp
  - plex
tlds:
  - com
  - net

This should produce the same output as shown in #2 above.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
