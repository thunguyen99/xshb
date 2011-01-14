# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each do|type|
      if flash[type]
        messages= "<div id=\"#{type}\">#{flash[type]}</div>"
      end
    end
    messages
  end

  def find_all_subcategories(category,text_indent=20)
    ret = ""
    text_indent += 15
    if category.children.size > 0
      category.children.each { |subcat|
        if subcat.children.size > 0
          ret += "<a href='/panel_contents?pcid=#{subcat.id}' style='text-indent:#{text_indent}px'><b>#{subcat.name}</b></a>"
          ret += find_all_subcategories(subcat,text_indent)
        else
          ret += "<a href='/panel_contents?pcid=#{subcat.id}' style='text-indent:#{text_indent}px'><b>#{subcat.name}</b></a>"
        end
      }
    end
    ret
  end

end
