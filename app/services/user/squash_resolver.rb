# frozen_string_literal: true

class User
  class SquashResolver < ApplicationService
    def initialize(params = {})
      @params           = params
      @resource         = params[:resource]
      @association_type = params[:association_type]
      @foreign_key      = params[:foreign_key]
      @source_id        = params[:source_id]
      @destination_id   = params[:destination_id]
      @squash           = params.fetch(:squash, false)
      @conditions       = params.fetch(:conditions, [])
    end

    def call
      return unless success?
      return resolve_relations! if association_type == HAS_MANY

      resolve_relation!
    end

    private

    HAS_MANY   = :has_many
    HAS_ONE    = :has_one

    attr_reader :params, :resource, :association_type, :foreign_key, :source_id, :destination_id, :squash, :conditions
    delegate :success?, to: :form

    def resolve_relations!
      collection = resource.where(foreign_key => source_id)
      return squash_relations!(collection) if squash

      update_relations!(collection)
    end

    def squash_relations!(collection)
      collection.each { |object| update_relation!(object) }
    end

    def update_relations!(collection)
      collection.update_all(foreign_key => destination_id)
    end

    def resolve_relation!
      object = resource.find_by(foreign_key => source_id)
      update_relation!(object)
    end

    def update_relation!(object)
      duplicate = resource.where(foreign_key => destination_id).find_by(criterion(object))

      return if duplicate.present? && duplicate.updated_at > object.updated_at

      duplicate&.destroy!
      object.update(foreign_key => destination_id)
    end

    def criterion(object)
      conditions.map { |column| [column, object.send(column)] }.to_h
    end

    def schema
      @schema ||= Dry::Validation.Schema do
        required(:resource).value(type?: Class)
        required(:association_type).value(included_in?: [HAS_MANY, HAS_ONE])
        required(:foreign_key).filled
        required(:source_id).filled(:int?)
        required(:destination_id).filled(:int?)
      end
    end

    def form
      schema.call(params)
    end
  end
end
