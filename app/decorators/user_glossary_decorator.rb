# coding: utf-8
module UserGlossaryDecorator
  def title_text
    "#{name} #{source_language} #{target_language}"
  end
  alias_method :link_text, :title_text
end
