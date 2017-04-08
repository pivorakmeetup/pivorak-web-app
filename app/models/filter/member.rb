module Filter
  class Member
    include ActiveModel::Model
    ATTRIBUTES = [:admin, :speaker, :synthetic, :verified]
    attr_accessor *ATTRIBUTES
  end
end
