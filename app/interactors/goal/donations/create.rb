class Goal
  module Donations
    class Create
      include Interactor::Organizer

      organize Setup, ::Donation::Create, Persist
    end
  end
end
