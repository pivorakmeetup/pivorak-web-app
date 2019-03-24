require 'rails_helper'

RSpec.describe 'Season SHOW' do
  context "season with 'registration' status" do
    let!(:season)  { create(:season, title: 'Test Season', status: :registration) }
    let!(:user)    { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
    let!(:student) { create(:student, season: season, user: user) }

    before { visit 'courses/seasons/test-season' }

    it "expect page to have needed links" do
      expect(page).to have_content 'Test Season'

      expect(page).to have_link     'Register'
      expect(page).not_to have_link 'Send Homework'
      expect(page).not_to have_link 'Pick interview time'
    end
  end

  context "season with 'selection' status" do
    let!(:season)  { create(:season, title: 'Test Season', status: :selection) }
    let!(:user)    { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
    let!(:student) { create(:student, season: season, user: user) }

    before { visit 'courses/seasons/test-season' }

    it "expect page to have needed links" do
      expect(page).to have_content 'Test Season'

      expect(page).not_to have_link 'Register'
      expect(page).not_to have_link 'Send test task'
      expect(page).not_to have_link 'Send Homework'
      expect(page).not_to have_link 'Pick interview time'
    end
  end

  context "season with 'live' status" do
    let!(:season)  { create(:season, title: 'Test Season', status: :live) }
    let!(:user)    { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
    let!(:student) { create(:student, season: season, user: user) }

    before { visit 'courses/seasons/test-season' }

    it "expect page to have needed links" do
      expect(page).to have_content 'Test Season'

      expect(page).to have_link     'Send Homework'
      expect(page).not_to have_link 'Register'
      expect(page).not_to have_link 'Send test task'
      expect(page).not_to have_link 'Pick interview time'
    end
  end

  describe "studend refuse link" do
    let!(:season)  { create(:season, title: 'Test Season') }
    let!(:user)    { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
    let!(:student) { create(:student, season: season, user: user, status: :attending) }

    context "student status is enrolled" do
      it 'shows link' do
        student.test_task_done!
        student.reload

        visit 'courses/seasons/test-season'

        expect(page).to have_link 'Cancel attendance'
      end
    end

    context "student status is test_task_done" do
      it 'shows link' do
        student.test_task_done!
        student.reload

        visit 'courses/seasons/test-season'

        expect(page).to have_link 'Cancel attendance'
      end
    end

    context "student status is interviewing" do
      it 'shows link' do
        student.interviewing!
        student.reload

        visit 'courses/seasons/test-season'

        expect(page).to have_link 'Cancel attendance'
      end
    end

    context "student status is attending" do
      it 'shows link' do
        student.attending!
        student.reload

        visit 'courses/seasons/test-season'

        expect(page).to have_link 'Cancel attendance'
      end
    end

    context "student status is dropped" do
      it 'shows no link' do
        student.dropped!
        student.reload

        visit 'courses/seasons/test-season'

        expect(page).not_to have_link 'Cancel attendance'
      end
    end

    context "student status is graduated" do
      it 'shows no link' do
        student.graduated!
        student.reload

        visit 'courses/seasons/test-season'

        expect(page).not_to have_link 'Cancel attendance'
      end
    end

    context "student status is refused" do
      it 'shows no link' do
        student.refused!
        student.reload

        visit 'courses/seasons/test-season'

        expect(page).not_to have_link 'Cancel attendance'
      end
    end
  end
end
