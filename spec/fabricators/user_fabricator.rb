Fabricator(:user) do
  name { Faker::Internet.user_name }
  uid { rand(2**32).to_s }
  provider 'github'
end
