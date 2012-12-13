module ApplicationHelper
  def base_url
    if Rails.env.production?
      ENV['BASE_URL']
    else
      "http://#{request.host_with_port}"
    end
  end

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

  def count_of_starting_position(per_count, current_page)
    per_count * (current_page - 1) + 1
  end

  def count_of_end_position(per_count, current_page, page_count)
    per_count * (current_page - 1) + page_count
  end

  def link_to_glossary_with(term)
    if term.github_project?
      github_project_id = term.glossary_name_without_github.sub(':', '/')
      bilingual_pair = [term.source_language, term.target_language].join('-')
      link_to(term.decorated_glossary_name, github_project_glossary_path(id: bilingual_pair, github_project_id: github_project_id))
    elsif term.user_glossary?
      owner = User.find(term.split_glossary_name_to_user_id_and_name[0])
      user_glossary = UserGlossary.find_by_term_and_user(term, owner)
      link_to(term.decorated_glossary_name, user_glossary_path(owner, user_glossary))
    end
  end

  def link_to_glossary_of_imported_project(project)
    bilingualr_pair_key = project.bilingualr_pair.join("-")
    glossary_id = [project.name, bilingualr_pair_key].join("/")
    link_to project.name, glossary_path(glossary_id)
  end
end
