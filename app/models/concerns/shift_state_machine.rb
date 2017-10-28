module ShiftStateMachine
  extend ActiveSupport::Concern

  included do
    # Allows states and transitions
    include AASM
    aasm column: 'state' do
      state :created, initial: true
      state :assigned
      state :completed
      state :missed

      after_all_transitions :log_status_change, :notify_user

      event :assign_vol do
        after do
        end
        error do |e|
        end
        transitions :from => :created, :to => :assigned
      end

      event :complete do
        after do
        end
        error do |e|
        end
        transitions :from => :assigned, :to => :completed
      end

      event :miss do
        success do
        end
        error do |e|
        end
        transitions :from => :assigned, :to => :missed
      end

    end

    def log_status_change
      puts "Shift changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    end

    def notify_user
      puts "sending user shift notification"
      case aasm.to_state
        when :assigned
          ShiftMailer.assigned(self.volunteer.id, self.event_day.event.id).deliver_later
        when :completed
          ShiftMailer.completed(self.user, self, self.event).deliver_later
        when :missed
          ShiftMailer.missed(self.user, self, self.event).deliver_later
      end
    end

  end
end