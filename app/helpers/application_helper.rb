module ApplicationHelper
  def logo
    image_tag("Logo_Darker_w_High_Pass_Emboss.gif", :alt => "logo" )
  end
  
  def bg_for_highlights
      "#FFE495"
  end
  
  def indent 
      indent = "&nbsp;&nbsp;&nbsp;&nbsp;"
  end

  def set_focus(id)
    javascript_tag("$('#{id}').focus()")
  end
  
  def is_pluralize(count, noun)
    verb = (count == 1) ? "is" : "are"
    "#{verb} #{pluralize(count, noun)}"
  end

  def tree_select(categories, model, name, selected=0, level=0, init=true)
    html = ""
    # The "Root" option is added
    # so the user can choose a parent_id of 0
    if init
        # Add "Root" to the options
        html << "<select name=\"#{model}[#{name}]\" id=\"#{model}_#{name}\">\n"
        html << "\t<option value=\"1\""
        if name == 'category_id'
            html << " selected=\"selected\"" if selected.id == 0
        else
            html << " selected=\"selected\"" if selected.parent_id == 0
        end
        html << ">Root</option>\n"
    end

    if categories.length > 0
      level += 1 # keep position
      categories.collect do |rlm|
        # if name == 'category_id'
            # html << "\t<option value=\"#{rlm.id}\" style=\"padding-left:#{level * 10}px\""
            # html << ' selected="selected"' if rlm.id == selected.id
        # else
            html << "\t<option value=\"#{rlm.id}\" style=\"padding-left:#{level * 10}px\""
            html << ' selected="selected"' if rlm.id == selected.id
            html << ' selected="selected"' if rlm.id == @parent_id
        # end
        html << ">#{rlm.name}</option>\n"
        html << tree_select(rlm.children, model, name, selected, level, false)
      end
    end
    html << "</select>\n" if init
    return html
  end
end
