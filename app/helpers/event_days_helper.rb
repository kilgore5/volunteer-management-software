module EventDaysHelper
  def total_shifts_for_job(job, day)

    total = 0

    job.rotations.each do |rotation|
      total += rotation.shifts.count
    end

    return total

  end

  def jobs_for_day(day)

  end
end
