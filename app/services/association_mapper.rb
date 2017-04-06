class AssociationMapper < ApplicationService
  def initialize(params)
    @associations = params
  end

  def call
    @associations.map { |association, prefixes| prefixes.map { |prefix| "#{prefix}_#{association}".to_sym } }.flatten
  end

  private

  attr_reader :associations
end
