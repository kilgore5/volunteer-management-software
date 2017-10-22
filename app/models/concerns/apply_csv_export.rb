module ApplyCsvExport
  extend ActiveSupport::Concern

  included do
    def self.to_csv
      attributes = %w{
        name
        email
        state
        submitted
        rating
        role_assignment
        shifts
        volunteered_before
        been_before
        terms_accepted
        e_contact_name
        e_contact_relationship
        e_contact_number
        stripe_id
      }
      # attributes << column_names
      CSV.generate(headers: true) do |csv|
        csv << attributes.map{ |attr| attr.titleize }
        all.each do |app|
          if app.user
            csv << attributes.map{ |attr| app.send(attr) }
          else
          end
        end
      end
    end
  end

  # Attributes for CSV download - converts user attributes into methods
  def name
    "#{user.last_name.titleize}, #{user.first_name.titleize}"
  end

  def email
    "#{user.email}"
  end

  def submitted
    "#{created_at.strftime("%Y-%m-%d")}"
  end

  def role_assignment
    if self.job.present?
      "#{self.job.title.truncate(10)}"
    end
  end

  def e_contact_name
    if user.emergency_contact.present?
      "#{user.emergency_contact.name}"
    end
  end

  def e_contact_relationship
    if user.emergency_contact.present?
      "#{user.emergency_contact.relationship}"
    end
  end

  def e_contact_number
    if user.emergency_contact.present?
      "#{user.emergency_contact.phone_number}"
    end
  end

  def stripe_id
    "#{user.stripe_customer_id}"
  end

  def shifts
    shift_times = []
    user.shifts.each do |s|
      shift = []
      shift << s.job.title
      shift << "#{s.length.to_s + 'hrs'}"
      shift << s.start_time.strftime("%l:%M%p %A %Y-%m-%d")
      shift_times << "#{shift.join(", ")}"
    end
    "#{shift_times.join("; ")}"
  end

end