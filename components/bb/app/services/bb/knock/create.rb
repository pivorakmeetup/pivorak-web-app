module Bb
  module Knock
    class Create < ::ApplicationService
      def initialize(user, book)
        @user = user
        @book = book
      end

      def call
        transaction do
          book.member_id = member.id
          book.save!
        end
      end

      private

      attr_reader :user, :book, :member

      def member
        @member = ::Bb::Member.create!(user_id: user.id)
      end
    end
  end
end
