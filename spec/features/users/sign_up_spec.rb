RSpec.describe 'Users Sign Up' do
  before do
    visit '/users/sign_up'
  end

  context 'when params are valid' do
    it 'creates user' do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.email

      fill_in 'First name', with: first_name
      fill_in 'Last name', with: last_name
      fill_in 'Email', with: email
      fill_in 'Password', with: '123456', match: :prefer_exact
      fill_in 'Password confirmation', with: '123456', match: :prefer_exact

      expect { click_button 'Sign up' }.to change(User, :count).by(1)

      new_user = User.last
      expect(new_user.first_name).to eq(first_name)
      expect(new_user.last_name).to eq(last_name)
      expect(new_user.email).to eq(email)
    end
  end

  context 'when params are invalid' do
    it 'validates errors' do
      fill_in 'Email', with: ''

      expect { click_button 'Sign up' }.to change(User, :count).by(0)
    end
  end
end
