class Donation
  include Charge
  include Customer
  include Token

  class Create
    include Interactor::Organizer

    organize Token::Generate, Customer::Create, Charge::Create

    def call
      super
    rescue ::Stripe::StripeError => e
      context.fail!(message: e.message)
    end
  end
end
