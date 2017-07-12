require 'spec_helper'
require './app/services/admin/courses/season/create.rb'

describe Admin::Courses::Season::Create do
  let(:params) { {title: "Title", start_at: Time.now, finish_at: Time.now + 100.days} }

  describe '#call' do
    it 'creates season with set of default questions' do
      season = Admin::Courses::Season::Create.call(params)
      season.save
      expect(season.questions.count).to eq(5)
    end
  end
end
