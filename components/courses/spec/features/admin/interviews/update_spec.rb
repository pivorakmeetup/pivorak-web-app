require 'rails_helper'

RSpec.describe 'Interviews UPDATE' do
  let!(:season)             { create(:season, title: 'Test Season', status: :selection) }
  let!(:user)               { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)             { ::Courses::Mentor.create(user: user, season: season) }
  let!(:interview)          { create(:interview, mentor: mentor, status: :pending) }

  let(:edit_interview_path) { '/admin/courses/seasons/test-season/interviews/1/edit' }
  let(:date_field_name)     { 'interview_start_at' }

  before { visit edit_interview_path }

  describe 'invalid input' do
    context 'blank start time' do
      it 'validates errors' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)

        interview.start_at = ''

        expect(interview).not_to be_valid
      end
    end
  end

  describe 'valid input' do
    context 'change of time' do
      it 'updates interview' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)
        date = '2017.10.10'.to_time
        pick_a_date(date_field_name, date)
        click_button 'Update Interview'
        interview.reload

        expect(page).to have_current_path '/admin/courses/seasons/test-season/interviews'
        expect(interview.start_at.strftime('%D')).to eq(date.strftime('%D'))
      end
    end

    context 'change of description' do
      it 'updates interview' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)
        fill_in 'Description',  with: 'Nice description'
        click_button 'Update Interview'
        interview.reload

        expect(page).to have_current_path '/admin/courses/seasons/test-season/interviews'
        expect(interview.description).to eq('Nice description')
      end
    end

    context 'change of video url' do
      it 'updates interview' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)
        fill_in 'Video url',  with: 'url.example/'
        click_button 'Update Interview'
        interview.reload

        expect(page).to have_current_path '/admin/courses/seasons/test-season/interviews'
        expect(interview.video_url).to eq('url.example/')
      end
    end

    context 'change of status' do
      it 'updates interview' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)
        select('missed', from: 'Status')
        click_button 'Update Interview'
        interview.reload

        expect(page).to have_current_path '/admin/courses/seasons/test-season/interviews'
        expect(interview.status).to eq('missed')
      end
    end
  end
end
