module Admin
  module DonationsHelper
    def total_donations
      Donation.all.map(&:amount).inject(:+).to_f.round(1)
    end
  end
end