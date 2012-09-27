#coding: utf-8

前提 /^"([^"]*)"リンクをクリックする$/ do |arg|
  click_on arg
end

もし /^"([^"]*)"に"([^"]*)"と入力する$/ do |name, val|
  fill_in name, with: val
end

もし /^"([^"]*)"をクリックする$/ do |arg|
  step %Q{"#{arg}"リンクをクリックする}
end

ならば /^対訳用語集"([^"]*)"が作成済みであること$/ do |glossary_name|
  page.should have_content(glossary_name)
end

