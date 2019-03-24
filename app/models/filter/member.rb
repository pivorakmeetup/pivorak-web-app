# frozen_string_literal: true

module Filter
  class Member
    include ActiveModel::Model
    ATTRIBUTES = %i[admin speaker synthetic verified].freeze
    attr_accessor(*ATTRIBUTES)
  end
end
