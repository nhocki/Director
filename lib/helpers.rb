require 'sinatra'

helpers do
  include Sinatra::Authorization
  
  # Function that checks if the HTTP referer comes from
  # one of the domains listed in the config file.
  def check_trusted_domain
    options.domains.any? do |domain|
      request.referer =~ create_escaped_regexp(domain)
    end
  end
  
  # Creates an escaped regex from a string.
  def create_escaped_regexp(exp)
    Regexp.new(Regexp.escape(exp))
  end
  
  # :nodoc:
  def pretty_date(obj)
    obj.created_at.strftime("%B %e, %Y")
  end
  
  # :nodoc:
  def from_trusted_site? (ours)
    if ours
      return "<span class='green'> trusted site </span>"
    else
      return "<span class='red'> untrusted site </span>"
    end
  end
  
  # Creates a simple link to the movement report
  def link_from_movement(movement)
    "<a href='/backstage/#{movement.id}'>watch report</a>"
  end
  
  # Checks if the request has a referer and returns it
  def check_referer
    if request.referer != "/"
      return request.referer
    else
      return ""
    end
  end
end
