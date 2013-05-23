require "ansi"
require "date"
require "whois"

class DomainCheck::SingleCheck
  def initialize(domain)
    @domain = domain.downcase
  end

  def check
    whois = Whois.whois(@domain)
    if whois.available?
      { :domain => @domain, :status => :available }
    else
      result = { :domain => @domain, :status => :registered }

      contact = whois.registrant_contact || whois.admin_contact ||
        whois.technical_contact || whois.contacts.first
      result[:contact_name] = contact.name if contact
      result[:contact_email] = contact.email if contact

      result[:created_at] = whois.created_on
      result[:expires_at] = whois.expires_on

      yield(result) if block_given?
      result
    end
  rescue Whois::Error
    { :domain => @domain, :status => :unknown }
  end
end
