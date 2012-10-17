# coding: utf-8
module UserConfigDecorator
  def mark_for(glossary)
    if same?(glossary)
      content_tag(:i, '', class: 'icon-star', title: '検索の結果表示で優先する設定を解除する')
    else
      content_tag(:i, '', class: 'icon-star-empty', title: '検索の結果表示で優先して表示する')
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
