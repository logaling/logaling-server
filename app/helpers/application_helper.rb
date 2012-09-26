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
end
