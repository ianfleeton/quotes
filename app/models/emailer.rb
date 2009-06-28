class Emailer < ActionMailer::Base
  def quote quote, sender, pdf_file
    subject quote.title
    recipients quote.to
    cc quote.cc
    from sender
    sent_on Time.now
    content_type "multipart/mixed"
    part :content_type => 'text/html', :body => render_message('quote', :html => quote.body)
    attachment :content_type => "application/pdf",
      :body => File.read(pdf_file), :filename => 'quote.pdf'
  end
end