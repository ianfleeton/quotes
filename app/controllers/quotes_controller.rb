class QuotesController < ApplicationController
  VAT_RATE = 15
  
  def index
    @quotes = Quote.all :order => 'created_at DESC'
  end
  
  def new
    @profile = Profile.find(:first)
    @items = Item.all :order => :position
  end
  
  def create
    @quote = Quote.new

    @profile = Profile.find(params[:profile_id])
    @profile.intro = params[:introduction]
    @profile.save

    if params[:title].empty?
      flash.now[:notice] = 'The quote form was not filled out correctly: A title must be specified'
      render :action => 'quote_help' and return
    elsif params[:reference].empty?
      flash.now[:notice] = 'The quote form was not filled out correctly: A quote reference must be specified'
      render :action => 'quote_help' and return
    elsif params[:to].empty?
      flash.now[:notice] = 'The quote form was not filled out correctly: A recipient must be specified'
      render :action => 'quote_help' and return
    end

    @quote.title = params[:title]
    @quote.reference = params[:reference]
    @quote.to = params[:to]
    @quote.cc = params[:cc]

    @sub_total = 0.00
    @details = ''

    q = ''

    q += '<p><strong>' + @quote.title
    q += '(Quotation number: ' + @quote.reference + ')</strong></p>'
    q += "\n<table id=\"quote\">\n"
	  q += "<tr><th class=\"qty\">Qty</th><th class=\"name\">Description</th>"
	  q += "<th class=\"unitprice\">Unit Price</th><th class=\"amount\">Amount</th></tr>\n"
    q += '</table>'

  	vat = @sub_total * (VAT_RATE.to_f / 100)
    
  	q += "<tr><td class=\"subempty\"></td><td class=\"subempty\"></td><td class=\"subtotallabel\">"
  	q += "Sub-total</td><td class=\"subtotal\">" + money(@sub_total) + "</td></tr>\n"
  	q += "<tr><td class=\"empty\"></td><td class=\"vatno\">VAT No GB 728 0266 38</td>"
  	q += "<td>VAT " + VAT_RATE.to_s + "%</td><td class=\"vat\">" + money(vat) + "</td></tr>\n"
  	total = @sub_total + vat
  	q += "<tr><td class=\"empty\"></td><td class=\"empty\"></td><td class=\"totallabel\">Total</td>"
  	q += "<td class=\"total\">" + money(total) + "</td></tr>\n"
  	q += "</table>\n"

    body = @profile.html
    body.gsub!('[quote]', q)
    body.gsub!('[introduction]', params[:introduction])
    body.gsub!('[details]', @details)

    @quote.save
    render :action => 'create', :layout => false
  end

  def send_or_back
    render :action => 'send_or_back', :layout => false
  end

  def preview
    render :action => 'preview', :layout => false
  end
  
  private

  def money(money)
  	money *= 100;
  	money = money.ceil
  	money /= 100
  	sprintf("%01.2f", money)
  end

end