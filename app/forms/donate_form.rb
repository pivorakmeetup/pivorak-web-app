# frozen_string_literal: true

class DonateForm
  include ActiveModel::Model
  attr_reader :agree_to_terms_of_use

  validates :agree_to_terms_of_use, acceptance: true
end
