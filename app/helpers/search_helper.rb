module SearchHelper
  def github_project?(glossary_name)
    glossary_name =~ /^github/
  end
end
