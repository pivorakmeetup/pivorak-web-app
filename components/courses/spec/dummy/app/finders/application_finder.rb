# frozen_string_literal: true

class ApplicationFinder
  def self.call(*args)
    new(*args).call
  end
end
