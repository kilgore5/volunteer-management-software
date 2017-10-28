module ApplyStateMachine
  extend ActiveSupport::Concern

  included do
    # Allows states and transitions
    include AASM
    aasm column: 'state' do
      state :submitted, initial: true
      state :accepted
      state :waitlisted
      state :denied
      state :confirmed

      after_all_transitions :log_status_change, :notify_user

      event :accept do
        after do
        end
        error do |e|
        end
        transitions :from => [:submitted, :waitlisted], :to => :accepted
      end

      event :waitlist do
        after do
        end
        error do |e|
        end
        transitions :from => :submitted, :to => :waitlisted
      end

      event :deny do
        success do
        end
        error do |e|
        end
        transitions :from => [:submitted, :waitlisted], :to => :denied
      end

      event :confirm do
        success do
        end
        error do |e|
        end
        transitions :from => :accepted, :to => :confirmed
      end

      event :second_chance do
        success do
        end
        error do |e|
        end
        transitions :from => :denied, :to => :accepted
      end

    end

    def log_status_change
      puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    end

    def notify_user
      puts "sending user notification"
      case aasm.to_state
        when :accepted
          if aasm.from_state == :denied
            ApplyMailer.second_chance(self.user, self, self.event).deliver_later
          else
            ApplyMailer.accepted(self.user, self, self.event).deliver_later
          end
        when :waitlisted
          ApplyMailer.waitlisted(self.user, self, self.event).deliver_later
        when :denied
          ApplyMailer.denied(self.user, self, self.event).deliver_later
        when :confirmed
          ApplyMailer.confirmed(self.user, self, self.event).deliver_later
      end
    end

  end
end