# Find error on the page in special div class for some resource
#
# it 'FAILS' do
#   fill_in 'Title', with: ''
#   click_button 'Submit'
#
#   expect_an_error resource_title: :blank
# end
#
def expect_an_error(hash_pair = {})
  field     = hash_pair.keys.first
  value     = hash_pair.values.first
  error_div = "div.#{field}.has-error"

  msg = if value == :blank
    "can't be blank"
  elsif value == :has_been_taken
    'has already been taken'
  else
    value
  end

  expect(page).to have_css(error_div)
  expect(find("#{error_div}")).to have_content(msg)
end

# Assume regular user (member) is logged in
#
# assume_logged_in
#
# or
#
# let(:my_user) { create :user, name: 'My User' }
# assume_logged_in(my_user)
#
def assume_logged_in(user = nil)
  user = user || create(:user)
  login_as(user)
end

# Assume admin user is logged in
def assume_admin_logged_in(admin = nil)
  admin = admin || create(:user, :admin)
  assume_logged_in(admin)
end
