class SearchController < ApplicationController
  helper_method :results

  private

  def results
    @results ||= ::Search::Multisearch.call(search_params)
  end

  def search_params
    params.merge(formatter: default_formatter)
  end

  def default_formatter
    ::Search::Formatters::Default
  end
end
