class DomainCheck::MultiCheck
  DEFAULT_TLDS = %w(com net org biz info name)

  def initialize(prefixes: nil, suffixes: nil, tlds: nil)
    @prefixes = prefixes
    @suffixes = suffixes
    @tlds     = tlds || DEFAULT_TLDS
    @tlds.each { |tld| tld.sub!(/^\./, '') }
  end

  def check
    domains.each do |domain|
      DomainCheck::SingleCheck.new(domain).check
    end
  end

  protected

  def domains
    unless @domains
      @prefixes.uniq! && @prefixes.sort! if @prefixes
      @suffixes.uniq! && @suffixes.sort! if @suffixes
      @tlds.sort! && @tlds.uniq!

      if @prefixes && @suffixes
        names = []
        @prefixes.each do |prefix|
          @suffixes.each do |suffix|
            @tlds.each do |tld|
              names << "#{ prefix }#{ suffix }.#{ tld }"
            end
          end
        end
        names
      elsif prefixes
        names = []
        @prefixes.each do |prefix|
          @tlds.each do |tld|
            names << "#{ prefix }.#{ tld }"
          end
        end
      elsif suffixes
        names = []
        @suffixes.each do |suffix|
          @tlds.each do |tld|
            names << "#{ prefix }#{ suffix }.#{ tld }"
          end
        end
        names  
      else
        []
      end
    end
  end
end
