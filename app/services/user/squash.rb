class User
  class Squash < ApplicationService
    def initialize(params = {})
      @params       = params
      @squshed_user = params.fetch(:squshed_user, nil)
      @into_user    = params.fetch(:into_user, nil)
    end

    def call
      return unless schema.call(params).success?
      return if squshed_user.id == into_user.id

      fix_has_many_dependencies!
      destroy_squashed_user!

      true
    end

    def dependencies
      {
        has_many: {
          Identity     => :user_id,
          Donation     => :user_id,
          Talk         => :speaker_id,
          VisitRequest => :user_id
        }
      }
    end

    private

    attr_reader :params, :squshed_user, :into_user, :result

    def fix_has_many_dependencies!
      dependencies[:has_many].each_pair do |resource, key|
        resource.where(key => squshed_user.id).update_all(key => into_user.id)
      end
    end

    def destroy_squashed_user!
      squshed_user.destroy
    end

    def schema
      @schema ||= Dry::Validation.Schema do
        required(:squshed_user).value(type?: User)
        required(:into_user).value(type?: User)
      end
    end
  end
end
