module ApplyJobAssignment
  extend ActiveSupport::Concern

  def assign_job(job_id)
    self.update_attributes(job_id: job_id)
  end

end