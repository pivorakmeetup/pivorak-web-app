# frozen_string_literal: true

require 'rails_helper'

describe Courses::Season::ShowTabPolicy do
  describe '#allowed?' do
    let(:allowed_for_planned)        { %w[mentors questions] }
    let(:forbidden_for_planned)      { %w[students test_task interviews lectures journal] }
    let(:allowed_for_registration)   { %w[mentors questions students test_task] }
    let(:forbidden_for_registration) { %w[interviews lectures journal] }
    let(:allowed_for_selection)      { %w[mentors students test_task interviews] }
    let(:forbidden_for_selection)    { %w[questions lectures journal] }
    let(:allowed_for_live)           { %w[mentors students lectures journal] }
    let(:forbidden_for_live)         { %w[test_task interviews questions] }
    let(:allowed_for_passed)         { %w[mentors students lectures journal test_task interviews] }
    let(:forbidden_for_passed)       { ['questions'] }

    describe 'status: planned' do
      let(:status) { 'planned' }

      context 'when allowed controller' do
        it 'allows to pass policy' do
          allowed_for_planned.each do |controller|
            expect(described_class.new(status, controller)).to be_allowed
          end
        end
      end

      context 'when forbidden controller' do
        it 'forbids to pass policy' do
          forbidden_for_planned.each do |controller|
            expect(described_class.new(status, controller)).not_to be_allowed
          end
        end
      end
    end

    describe 'status: registration' do
      let(:status) { 'registration' }

      context 'when allowed controller' do
        it 'allows to pass policy' do
          allowed_for_registration.each do |controller|
            expect(described_class.new(status, controller)).to be_allowed
          end
        end
      end

      context 'when forbidden controller' do
        it 'forbids to pass policy' do
          forbidden_for_registration.each do |controller|
            expect(described_class.new(status, controller)).not_to be_allowed
          end
        end
      end
    end

    describe 'status: selection' do
      let(:status) { 'selection' }

      context 'when allowed controller' do
        it 'allows to pass policy' do
          allowed_for_selection.each do |controller|
            expect(described_class.new(status, controller)).to be_allowed
          end
        end
      end

      context 'when forbidden controller' do
        it 'forbids to pass policy' do
          forbidden_for_selection.each do |controller|
            expect(described_class.new(status, controller)).not_to be_allowed
          end
        end
      end
    end

    describe 'status: live' do
      let(:status) { 'live' }

      context 'when allowed controller' do
        it 'allows to pass policy' do
          allowed_for_live.each do |controller|
            expect(described_class.new(status, controller)).to be_allowed
          end
        end
      end

      context 'when forbidden controller' do
        it 'forbids to pass policy' do
          forbidden_for_live.each do |controller|
            expect(described_class.new(status, controller)).not_to be_allowed
          end
        end
      end
    end

    describe 'status: passed' do
      let(:status) { 'passed' }

      context 'when allowed controller' do
        it 'allows to pass policy' do
          allowed_for_passed.each do |controller|
            expect(described_class.new(status, controller)).to be_allowed
          end
        end
      end

      context 'when forbidden controller' do
        it 'forbids to pass policy' do
          forbidden_for_passed.each do |controller|
            expect(described_class.new(status, controller)).not_to be_allowed
          end
        end
      end
    end
  end
end
