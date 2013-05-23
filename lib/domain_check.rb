require "yaml"

require_relative "domain_check/version"
require_relative "domain_check/console_formatter"
require_relative "domain_check/multi_check"
require_relative "domain_check/single_check"

module DomainCheck
  extend self

  def new(domain: nil, file: nil, prefixes: nil, suffixes: nil, tlds: nil)
    if domain
      SingleCheck.new(domain)
    elsif file
      config = parse_file(file)
      MultiCheck.new(prefixes: config['prefixes'], suffixes: config['suffixes'], tlds: config['tlds'])
    elsif prefixes && suffixes && tlds
      MultiCheck.new(prefixes: prefixes, suffixes: suffixes, tlds: tlds)
    elsif prefixes || suffixes || tlds
      raise ArgumentError, "Must supply prefixes, suffixes, and TLDs"
    else
      raise ArgumentError, "No arguments given"
    end
  end

  protected

  def parse_file(filename)
    YAML.load_file(filename)
  end

end
