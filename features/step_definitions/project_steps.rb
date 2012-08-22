#coding: utf-8

前提 /^トップページを表示している$/ do
  visit '/'
end

前提 /^プロジェクト登録画面を表示する$/ do
  visit '/github/new'
end

もし /^"([^"]*)"ユーザの"([^"]*)"プロジェクトを登録する$/ do |owner, project|
  fill_in 'github_project_owner', with: owner
  fill_in 'github_project_name', with: project
  click_on 'Save'
end

ならば /^"([^"]*)"ユーザの"([^"]*)"プロジェクトが登録済みであること$/ do |owner, project|
  visit "/github/#{owner}/#{project}"
  page.should have_content(project)
end
