#coding: utf-8

もし /^"([^"]*)"にパラメータを付けずに直接アクセスする$/ do |path|
  visit path
end
