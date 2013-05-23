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
      puts "#{ @domain.ljust(24).ansi.bold.blue } #{ "AVAILABLE".ansi.bold.green }"
    else
      contact = whois.registrant_contact || whois.admin_contact ||
        whois.technical_contact || whois.contacts.first
      created = whois.created_on
      expires = whois.expires_on
      facts = []
      if contact
        name    = contact.name if contact
        email   = contact.email if contact
        facts << "contact: #{ name }" if name
        facts << "email: #{ email }" if email
      end
      if created
        facts << "since: #{ created.to_date.to_s }"
      end
      if expires
        if expires.to_date - Date.today < 60
          facts << "expires: #{ expires.to_date.to_s }".ansi.yellow.bold
        else
          facts << "expires: #{ expires.to_date.to_s }"
        end
      end
      puts "#{ @domain.ljust(24).ansi.bold.blue } #{ "REGISTERED".ansi.red.bold }" +
        (", #{ facts.join(", ") }" if facts)
    end
  rescue Whois::Error
    puts "#{ @domain.ljust(24).ansi.bold.blue } #{ "UNKNOWN".ansi.red.negative.bold }"
  end
end
