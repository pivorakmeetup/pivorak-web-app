# frozen_string_literal: true

def active_jobs
  ActiveJob::Base.queue_adapter.enqueued_jobs
end
