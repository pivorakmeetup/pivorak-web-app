require 'rails_helper'

RSpec.describe 'Student CREATE' do
  let!(:season)                { create(:season, title: 'Test Season') }
  let!(:user)                  { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let(:test_new_students_path) { '/courses/seasons/test-season/students/new' }

  before { visit test_new_students_path }

  describe 'invalid input' do
   context 'blank personal_info' do
     it 'validates errors' do
       fill_in 'Personal info', with: ''
       fill_in 'Motivation info', with: 'Food!'
       click_button 'Create Student'

       expect_an_error student_personal_info:  :blank
     end
   end

   context 'blank motivation_info' do
     it 'validates errors' do
       fill_in 'Personal info', with: 'Personal stuff'
       fill_in 'Motivation info', with: ''
       click_button 'Create Student'

       expect_an_error student_motivation_info:  :blank
     end
   end
  end

  describe 'valid input' do
   context 'first application try' do
     it 'creates new student' do
       allow_any_instance_of(Courses::Student::CreatePolicy).to receive(:allowed?).and_return(true)
       fill_in 'Personal info', with: 'Personal stuff'
       fill_in 'Motivation info', with: 'Food!'
       expect { click_button 'Create Student' }.to change{ ::Courses::Student.count }.by(1)
     end
   end

   context 'second application try' do
     it 'creates new student' do
       allow_any_instance_of(Courses::Student::CreatePolicy).to receive(:allowed?).and_return(false)
       fill_in 'Personal info', with: 'Personal stuff'
       fill_in 'Motivation info', with: 'Food!'
       expect { click_button 'Create Student' }.not_to change{ ::Courses::Student.count }
     end
   end
  end
end
