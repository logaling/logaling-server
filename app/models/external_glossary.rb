#coding: utf-8

class ExternalGlossary
  class << self
    #extected_id_format: "(project_name)/(source_language)-(target_language)"
    def find(id)
      project_name, bilingual_pair = id.split('/', 2)
      source_language, target_language = bilingual_pair.split('-', 2)
      new(project_name: project_name, source_language: source_language, target_language: target_language)
    end
  end
  include ActiveAttr::Model

  attribute :project_name,    type: String, default: ''
  attribute :source_language, type: String, default: ''
  attribute :target_language, type: String, default: ''

  def project
    LogalingServer.repository.find_project(project_name)
  end

  def terms
    glossary.terms
  end

  private
  def glossary
    project.glossary(source_language, target_language)
  end
end
