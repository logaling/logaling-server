#coding: utf-8

前提 /^トップページを表示している$/ do
  visit '/'
end

前提 /^プロジェクト登録画面を表示する$/ do
  visit '/github/new'
end

前提 /^"([^"]*)"ユーザの"([^"]*)"プロジェクトが登録済みである$/ do |owner, project|
  GithubProject.create!(owner: owner, name: project)
end

もし /^"([^"]*)"ユーザの"([^"]*)"プロジェクトを登録する$/ do |owner, project|
  fill_in 'github_project_owner', with: owner
  fill_in 'github_project_name', with: project
  click_on 'Save'
end

もし /^"([^"]*)"と検索する$/ do |query|
  fill_in 'query', with: query
  click_on 'Search'
end

ならば /^"([^"]*)"ユーザの"([^"]*)"プロジェクトが登録されていないこと$/ do |owner, project|
  visit "/github/#{owner}/#{project}"
  page.status_code.should eq 404
end

ならば /^"([^"]*)"ユーザの"([^"]*)"プロジェクトが登録済みであること$/ do |owner, project|
  visit "/github/#{owner}/#{project}"
  page.should have_content(project)
end

ならば /^"([^"]*)"と表示されていること$/ do |text|
  page.should have_content(text)
end
