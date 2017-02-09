module SearchHelper
  def resource_template(klass)
    "search/templates/#{klass.model_name.i18n_key}"
  end
end
