namespace :searchable do
  desc 'reindex models that include searchable module for multisearch purposes'
  task reindex: :environment do
    Rails.application.eager_load!

    models = ApplicationRecord.descendants.select { |m| m.respond_to? :pg_search_multisearchable_options }
    models.each { |model_name| PgSearch::Multisearch.rebuild(model_name) }

    p "Finished reindexing total of #{models.count} models"
  end
end
