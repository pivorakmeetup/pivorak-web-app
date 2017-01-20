def active_jobs
  ActiveJob::Base.queue_adapter.enqueued_jobs
end
