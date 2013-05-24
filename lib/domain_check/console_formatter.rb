require "ansi"
require "date"

class DomainCheck::ConsoleFormatter
  def initialize(result)
    @result = result
  end

  def format
    if @result
      domain = @result[:domain].ljust(24).ansi.bold.blue

      if @result[:status] == :available
        status = @result[:status].to_s.upcase.ansi.bold.green
        puts "#{ domain } #{ status }"

      elsif @result[:status] == :registered
        status        = @result[:status].to_s.upcase.ansi.bold.red
        contact_name  = @result[:contact_name]
        contact_email = @result[:contact_email]
        
        created_on    = @result[:created_at]
        created_on    = created_on.to_date.to_s if created_on

        expires_in    = nil
        if @result[:expires_at]
          today = Date.today
          days = (@result[:expires_at].to_date - today).to_i
          expires_in = "#{ days } days"
          if days <= 60
            expires_in = expires_in.ansi.yellow.bold
          end
        end

        params = { contact: contact_name, email: contact_email,
          created: created_on, expires: expires_in }
        params.reject! { |k,v| v.nil? }
        param_string = params.to_a.map { |a| "#{ a[0] }: #{ a[1] }" }.join(", ")
        puts "#{ domain } #{ status }" + (", #{ param_string }" if param_string)

      elsif @result[:status] == :unknown
        puts "#{ domain } #{ "UNKNOWN".ansi.red.negative.bold }"

      end
    end
  end
end
