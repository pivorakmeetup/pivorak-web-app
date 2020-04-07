# frozen_string_literal: true

RSpec.describe 'Home READ' do
  before do
    assume_admin_logged_in
    visit '/admin'
  end

  it { expect(page).to have_link 'App'     }
  it { expect(page).to have_link 'Admin'   }
  it { expect(page).to have_link 'Events'  }
  it { expect(page).to have_link 'Talks'   }
  it { expect(page).to have_link 'Venues'  }
  it { expect(page).to have_link 'Members' }
  it { expect(page).to have_link 'Groups'  }
  it { expect(page).to have_link 'Emails'  }
  it { expect(page).to have_link 'Friends' }
  it { expect(page).to have_link 'Pages'   }
end
