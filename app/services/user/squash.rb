# frozen_string_literal: true

class User
  class Squash < ApplicationService
    def initialize(params = {})
      @params        = params
      @squashed_user = params.fetch(:squashed_user, nil)
      @into_user     = params.fetch(:into_user, nil)
    end

    def call
      return unless schema.call(params).success?
      return if squashed_user.id == into_user.id

      transaction do
        fix_has_many_dependencies!
        destroy_squashed_user!
      end

      true
    end

    def dependencies
      {
        has_many: {
          Identity     => { foreign_key: :user_id },
          Donation     => { foreign_key: :user_id },
          Talk         => { foreign_key: :speaker_id },
          VisitRequest => { foreign_key: :user_id, squash: true, conditions: %i[event_id] }
        }
      }
    end

    private

    attr_reader :params, :squashed_user, :into_user

    def fix_has_many_dependencies!
      dependencies[:has_many].each_pair do |resource, options|
        ::User::SquashResolver.call(
          resource:         resource,
          association_type: :has_many,
          foreign_key:      options[:foreign_key],
          source_id:        squashed_user.id,
          destination_id:   into_user.id,
          squash:           options[:squash],
          conditions:       options[:conditions]
        )
      end
    end

    def destroy_squashed_user!
      squashed_user.destroy!
    end

    def schema
      @schema ||= Dry::Validation.Schema do
        required(:squashed_user).value(type?: User)
        required(:into_user).value(type?: User)
      end
    end
  end
end
