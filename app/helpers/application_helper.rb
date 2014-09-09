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
end
