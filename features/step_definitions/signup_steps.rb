#coding: utf-8

前提 /^ユーザ"([^"]*)"でログインしている$/ do |name|
  page.reset_session!
  uid = SecureRandom.hex(8)
  OmniAuth.config.add_mock(:github, uid: uid, info: {name: name})
  user = Fabricate(:user, name: name, provider: 'github', uid: uid)
  visit '/auth/github'
end

前提 /^ダッシュボードを表示している$/ do
  visit '/dashboard'
end
