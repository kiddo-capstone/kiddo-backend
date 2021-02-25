require "rails_helper"

describe UserMailer  do
  describe "invite" do
    context "headers" do
      it "renders the subject" do
        user = create(:user, email: "shaundanejames@gmail.com")
        mail = described_class.invite(user)

        expect(mail.subject).to eq I18n.t("user_mailer.invite.subject")
      end

      it "sends to the right email" do
        user = create(:user, email: "shaundanejames@gmail.com")

        mail = described_class.invite(user)

        expect(mail.to).to eq [user.email]
      end

      it "renders the from email" do
        user = create(:user, email: "shaundanejames@gmail.com")

        mail = described_class.invite(user)

        expect(mail.from).to eq ["from@example.com"]
      end
    end
  end
end
