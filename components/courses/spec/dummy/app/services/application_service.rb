# frozen_string_literal: true

class ApplicationService
  delegate :transaction, to: ApplicationRecord

  def self.call(*args)
    new(*args).call
  end
end
