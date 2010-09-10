# coding: utf-8
class QuotesController < ApplicationController
  before_filter :setup_nav, :admin_required
  before_filter :find_quote, :only => [:send_or_back, :preview, :send_quote, :destroy]

  VAT_RATE = 17.5
  
  def index
    @quotes = @current_profile.quotes
  end
  
  def new
  end
  
  def create
    @quote = Quote.new
    @quote.profile_id = @current_profile.id

    # update profile default introduction
    @current_profile.intro = params[:introduction]
    @current_profile.save

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
    q += ' (Quotation number: ' + @quote.reference + ')</strong></p>'
    q += "\n<table id=\"quote\">\n"
	  q += "<tr><th class=\"qty\">Qty</th><th class=\"name\">Description</th>"
	  q += "<th class=\"unitprice\">Unit Price</th><th class=\"amount\">Amount</th></tr>\n"

  	if params[:items]
  		params[:items].each_pair do |item_id, qty|
  		  qty = qty.to_f
  		  unless qty == 0
  		    item = Item.find(item_id)
					q += quote_line(item.name, item.price_in_pounds.to_f, qty)
					unless item.information.empty?
					  @details += "\n\n<h2>" + item.name + "</h2>\n"
					  @details += item.information
				  end
  			end
  		end
  	end
  	
  	# extra items
  	params[:x_qty].length.times do |i|
  	  i = i.to_s
  	  begin
  	    x_qty = params[:x_qty][i].to_f
  	    x_name = params[:x_name][i]
  	    x_price = params[:x_price][i]
  	    x_price.gsub!(/[,£]/,'')
  	    x_price = x_price.to_f
  	    if x_qty != 0
          q += quote_line(x_name, x_price, x_qty)
        end
	    rescue
	      next
      end
	  end

  	vat = @sub_total * (VAT_RATE.to_f / 100)
    
  	q += "<tr><td class=\"subempty\"></td><td class=\"subempty\"></td><td class=\"subtotallabel\">"
  	q += "Sub-total</td><td class=\"subtotal\">" + money(@sub_total) + "</td></tr>\n"
  	q += "<tr><td class=\"empty\"></td>"
  	if @current_profile.vat_number.empty?
  	  q += "<td class=\"empty\">"
  	else
  	  q += "<td class=\"vatno\">VAT No " + @current_profile.vat_number
  	end
  	q += "</td>"
  	q += "<td>VAT " + VAT_RATE.to_s + "%</td><td class=\"vat\">" + money(vat) + "</td></tr>\n"
  	total = @sub_total + vat
  	q += "<tr><td class=\"empty\"></td><td class=\"empty\"></td><td class=\"totallabel\">Total</td>"
  	q += "<td class=\"total\">" + money(total) + "</td></tr>\n"
  	q += "</table>\n"

    body = @current_profile.html
    body.gsub!('[quote]', q)
    body.gsub!('[introduction]', params[:introduction])
    body.gsub!('[details]', @details)

    @quote.body = body
    @quote.save
    
    render :action => 'create', :layout => false
  end

  def file_for_quote ext
    File::join(RAILS_ROOT, 'pdf', 'html_tmp', 'quote' + @quote.id.to_s + '.' + ext)
  end

  def generate_pdf
    html = file_for_quote '.html'
    f = File.new(html, 'w')
    f.puts @quote.body
    f.close
    
    dompdf = File::join(RAILS_ROOT, 'pdf', 'dompdf-0.5.1', 'dompdf.php')
    cmd = "php #{dompdf} -p a4 #{html}"
    system(cmd)
  end

  def send_or_back
    render :action => 'send_or_back', :layout => false
  end

  def preview
    render :action => 'preview', :layout => false
  end
  
  def send_quote
    generate_pdf
    Emailer.deliver_quote(@quote, @current_profile.from, file_for_quote('.pdf'))
    @quote.sent_at = Time.now
    @quote.save
    flash[:notice] = 'Quote sent'
    redirect_to :action => 'index'
  end

  def destroy
    @quote.destroy
    flash[:notice] = 'Quote deleted.'
    redirect_to quotes_url
  end
  
  private

  def money(money)
  	money *= 100
  	money = money.ceil
  	money /= 100.0
  	sprintf("%01.2f", money)
  end

  def quote_line(name, unit_price, quantity=1)
    display_qty = quantity.to_s
    if display_qty[-2,2] == '.0'
      display_qty = display_qty[0,display_qty.length-2]
    end
  	line = ''

  	line += '<tr><td class="qty">' + display_qty + '</td>'
  	line += '<td class="name">' + name + '</td>'
  	line += '<td class="unitprice">'
  	if(unit_price == 0)
  	  line += 'FOC'
  	else
  	  line += money(unit_price)
	  end
  	line += '</td>'
  	amount = unit_price * quantity
  	line += '<td class="amount">' + money(amount) + '</td>'
  	line += "</tr>\n"
  	@sub_total += amount

  	line
  end

  def setup_nav
    @nav = 'quotes'
  end

  def find_quote
    @quote = Quote.find(params[:id])
  end
end