module ApplicationHelper
  def render_sinpped(snipped, tag=:strong)
    buffer = ""
    snipped.each do |component|
      buffer << if component.is_a?(Hash)
        content_tag tag, component[:keyword]
      else
        h(component)
      end
    end
    raw(buffer)
  end

  def github_project?(glossary_name)
    glossary_name =~ /^github/
  end

  def count_of_starting_position(per_count, current_page)
    per_count * (current_page - 1) + 1
  end

  def count_of_end_position(per_count, current_page, page_count)
    per_count * (current_page - 1) + page_count
  end

end
