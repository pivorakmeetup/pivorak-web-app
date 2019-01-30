class DatePresenter < BasePresenter
  presents :date

  def day
    @day ||= date.strftime('%a')
  end

  def month
    @month ||= date.strftime('%b')
  end

  def day_of_the_month
    @day_of_the_month ||= date.strftime('%d')
  end

  def hour
    @hour ||= date.strftime('%H:%M')
  end
end