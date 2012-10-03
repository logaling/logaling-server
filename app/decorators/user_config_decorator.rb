# coding: utf-8
module UserConfigDecorator
  def mark_for(glossary)
    if same?(glossary)
      content_tag(:i, '', class: 'icon-star')
    else
      content_tag(:i, '', class: 'icon-star-empty')
    end
  end

  def submit_path_for(user)
    if new_record?
      user_configs_path(user)
    else
      user_config_path(user, self)
    end
  end
end
