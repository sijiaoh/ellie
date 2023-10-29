module ApplicationHelper
  def ga_measurement_id
    Utils.env_or_secret "ga_measurement_id", ""
  end
end
