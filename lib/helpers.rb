require 'sinatra'

helpers do
  include Sinatra::Authorization
  def check_trusted_domain
    options.domains.any? do |domain|
      request.referer =~ create_escaped_regexp(domain)
    end
  end
  
  def create_escaped_regexp(exp)
    Regexp.new(Regexp.escape(exp))
  end
  
  def pretty_date(obj)
    obj.created_at.strftime("%B %e, %Y")
  end
  
  def from_trusted_site? (ours)
    if ours
      return "<span class='green'> trusted site </span>"
    else
      return "<span class='red'> untrusted site </span>"
    end
  end
  
  def link_from_movement(movement)
    "<a href='/backstage/#{movement.id}'>watch report</a>"
  end
  
  def check_referer
    if request.referer != "/"
      return request.referer
    else
      return ""
    end
  end
end
