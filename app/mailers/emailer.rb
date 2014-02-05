class Emailer < ActionMailer::Base
  def quote(quote, sender, pdf_file)
    attachments['quote.pdf'] = File.read(pdf_file)

    mail(:to => quote.to, :from => sender, :subject => quote.title, :cc => quote.cc) do |format|
      format.html { render :text => quote.body }
    end
  end
end
