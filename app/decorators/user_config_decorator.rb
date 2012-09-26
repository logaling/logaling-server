# coding: utf-8
module UserConfigDecorator
  def mark_for(glossary)
    same?(glossary) ? "★" : "☆"
  end

  def submit_path_for(user)
    if new_record?
      user_configs_path(user)
    else
      user_config_path(user, self)
    end
  end
end
