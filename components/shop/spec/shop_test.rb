# frozen_string_literal: true

require 'test_helper'

module Shop
  class Test < ActiveSupport::TestCase
    test 'truth' do
      assert_kind_of Module, Shop
    end
  end
end
