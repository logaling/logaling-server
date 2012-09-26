module SearchHelper
  def github_project?(glossary_name)
    glossary_name =~ /^github/
  end

  def get_term_id(term_hash)
    Term.new(term_hash).id
  end
end
