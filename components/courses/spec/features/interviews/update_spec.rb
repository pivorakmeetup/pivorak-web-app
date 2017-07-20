require 'rails_helper'

RSpec.describe 'Interviews UPDATE' do
  let!(:season)             { create(:season, title: 'Test Season') }
  let(:edit_interview_path) { '/admin/courses/seasons/test-season/interviews/1/edit' }
  let!(:user)               { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:mentor)             { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:interview)          { create(:interview, mentor_id: mentor.id, status: 1) }

  before { visit edit_interview_path }

  describe 'invalid input' do
    context 'blank start time' do
      it 'validates errors' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)
        fill_in 'Start at',  with: ''
        click_button 'Update Interview'

        expect_an_error interview_start_at: :blank
      end
    end

    context 'invalid interval' do
      it 'validates errors' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(false)
        fill_in 'Start at',  with: (Time.now).to_s
        click_button 'Update Interview'

        expect_an_error interview_start_at: 'should be at least 30 minutes between interviews'
      end
    end
  end

  describe 'valid input' do
    context 'change of time' do
      it 'updates interview' do
        allow_any_instance_of(Courses::Interview::IntervalPolicy).to receive(:allowed?).and_return(true)
        fill_in 'Start at',  with: '2017.06.06'.to_time
        click_button 'Update Interview'
        interview.reload

        expect(page).to have_current_path '/admin/courses/seasons/test-season/interviews'
        expect(interview.start_at).to eq('2017-06-06'.to_time)
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
