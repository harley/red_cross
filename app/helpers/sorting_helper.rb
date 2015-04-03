module SortingHelper
  def sorting_url(column, direction = nil, &blk)
    direction = sorting_direction || :asc

    column = column.to_s
    column.prepend('-') if direction == :asc

    blk.call(url_for(sort: column), direction)
  end

  def sorting_link(column, label)
    sorting_url(column) do |url, direction|
      link = link_to(label, url)

      if column == sorting_column || column[1..-1] == sorting_column
        down = " <i class='glyphicon glyphicon-chevron-down'></i>".html_safe
        up = " <i class='glyphicon glyphicon-chevron-up'></i>".html_safe
        link += direction == :asc ? up : down
      end
      raw link
    end
  end
end
