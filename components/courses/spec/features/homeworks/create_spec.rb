require 'rails_helper'

RSpec.describe 'Homework CREATE' do
  let!(:season)  { create(:season, title: 'Test Season') }
  let!(:user)    { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:student) { create(:student, season_id: season.id, user_id: user.id) }

  before { visit '/courses/seasons/test-season/homeworks/new' }

  describe 'invalid input' do
   context 'blank git_url' do
     it 'validates errors' do
       fill_in 'Git url', with: ''
       fill_in 'Description', with: 'This homework is awesome!'
       click_button 'Create Homework'

       expect_an_error homework_git_url:  :blank
     end
   end

   context 'blank description' do
     it 'validates errors' do
       fill_in 'Git url', with: 'https://github.com/test_student/homework_test'
       fill_in 'Description', with: ''
       click_button 'Create Homework'

       expect_an_error homework_description:  :blank
     end
   end
  end

  describe 'valid input' do
    it 'creates new homework' do
      fill_in 'Git url', with: 'https://github.com/test_student/homework_test'
      fill_in 'Description', with: 'This homework is awesome!'
      expect { click_button 'Create Homework' }.to change{ ::Courses::Homework.count }.by(1)
    end
  end
end
