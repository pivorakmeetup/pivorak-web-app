class User
  class Create < Base
    def call
      synthetic_user! if synthetic?

      user.save
    end

    private

    def synthetic_user!
      user.synthetic = true
      user.skip_confirmation!
      user.password  = SecureRandom.hex(16)
    end

    def synthetic?
      options[:synthetic]
    end
  end
end
