class BasePresenter < SimpleDelegator
  delegate :t, :current_user, :present, :link_to, :render, to: :h

  def self.presents(name)
    define_method(name) do
      @model
    end
  end

  def initialize(model, view)
    @view  = view
    @model = model

    super(model)
  end

  def h
    @view
  end
end