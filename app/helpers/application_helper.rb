module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = "asc"

    if sorting_params[:col] == column.to_s
      direction = (sorting_params[:dir] == "asc") ? "desc" : "asc"
      title += "#{direction == 'asc' ? '▲' : '▼'}"
    end

    link_to title, params.merge(:sort => {:col => column, :dir => direction}), {:class => direction}
  end

  def can_link_to(name=nil, object=nil, html_options=nil)
    if policy(object).show?
      link_to(name, object, html_options)
    else
      name
    end
  end

end
