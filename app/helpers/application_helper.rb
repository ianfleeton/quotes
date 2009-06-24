# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_notice 
    if flash[:notice] 
      content_tag('div', h(flash[:notice]), {:id => "flash_notice"}) 
    end 
  end
  
  def format_date d
    if (Time.now - d) < 2.minutes
      'Just a moment ago'
    elsif (Time.now - d) < 1.hours
      ((Time.now - d)/60).ceil.to_s + ' minutes ago'
    elsif d.today?
      'Today at ' + d.strftime("%l:%M%p").downcase
    elsif (d+1.day).today?
      'Yesterday at ' + d.strftime("%l:%M%p").downcase
    elsif (Time.now - d) < 1.week
      d.strftime('%A at ') + d.strftime("%l:%M%p").downcase
    elsif d.year == Time.now.year
      d.strftime("%e %b at ") + d.strftime("%l:%M%p").downcase
    else
      d.strftime("%e %b %Y at ") + d.strftime("%l:%M%p").downcase
    end
  end
  
  def clear
    content_tag('p', '&nbsp;', {:class => 'clear'})
  end
end
