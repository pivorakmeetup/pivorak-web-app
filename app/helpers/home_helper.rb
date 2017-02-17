module HomeHelper
  def get_day(date)
    date.strftime("%a")
  end

  def get_month(date)
    date.strftime("%b")
  end

  def get_day_of_the_month(date)
    date.strftime("%d")
  end

  def get_hour(date)
    date.strftime("%H:%M")
  end
end
