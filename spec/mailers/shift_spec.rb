require "rails_helper"

RSpec.describe ShiftMailer, type: :mailer do
  describe "assigned" do
    let(:mail) { ShiftMailer.assigned }

    it "renders the headers" do
      expect(mail.subject).to eq("Assigned")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "changed" do
    let(:mail) { ShiftMailer.changed }

    it "renders the headers" do
      expect(mail.subject).to eq("Changed")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
