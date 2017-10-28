# Preview all emails at http://localhost:3000/rails/mailers/shift
class ShiftPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/shift/assigned
  def assigned
    ShiftMailer.assigned
  end

  # Preview this email at http://localhost:3000/rails/mailers/shift/changed
  def changed
    ShiftMailer.changed
  end

end
