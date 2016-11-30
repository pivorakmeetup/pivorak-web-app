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
  error_div = "div.#{field}.field_with_errors"

  msg = if value == :blank
    "can't be blank"
  elsif value == :has_been_taken
    'has already been taken'
  else
    value
  end

  expect(page).to have_css(error_div)
  expect(find("#{error_div} span.error")).to have_content(msg)
end
