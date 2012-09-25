# coding: utf-8
module UserConfigDecorator
  def mark_for(user_glossary)
    self.same?(user_glossary) ? "★" : "☆"
  end

  def submit_path_for(user)
    if self.new_record?
      user_configs_path(user)
    else
      user_config_path(user, self)
    end
  end
end
