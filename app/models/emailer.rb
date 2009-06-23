class Emailer < ActionMailer::Base
  def quote quote, sender
    subject quote.title
    recipients quote.to
    cc quote.cc
    from sender
    sent_on Time.now
    body :html => quote.body
    content_type "text/html"
  end
end