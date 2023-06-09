module RoutineHelper
  def allow_submit_routine_report?(routine)
    accept_submission?(routine)
  end

  def allow_submit_routine_setback?(routine)
    accept_submission?(routine)
  end

  def routine_day_selected?(routine, day)
    return false if routine.nil? || routine.days.nil?

    routine.days.include?(day)
  end

  private

  def accept_submission?(routine)
    today = Time.zone.today.strftime('%A').downcase
    current_date = Time.zone.now.to_date
    current_time = Time.zone.now
    last_report = routine.last_report
    last_setback = routine.last_setback

    return false unless current_time.hour >= 22 && current_time.hour <= 23

    return false if routine.completed?

    return false unless routine.days.include?(today)

    return false if !last_report.nil? && last_report.to_date >= current_date

    return false if !last_setback.nil? && last_setback.to_date >= current_date

    true
  end
end
