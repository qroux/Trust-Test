class EnrichAllJob < ApplicationJob
  queue_as :default

  def perform(employment)
    FetchApi.perform_query(employment)
  end
end
