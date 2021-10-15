require "rails_helper"

RSpec.describe Message, type: :model do
  describe "validations" do
    context "when body is not present" do
      it "is invalid" do
        body = ""
        message = Message.new(body: body)

        expect(message).to be_invalid
        expect(message.errors.of_kind?(:body, :blank)).to eq true
      end
    end

    context "when body is present" do
      it "is invalid" do
        body = "some text to display"
        message = Message.new(body: body)

        expect(message).to be_valid
      end
    end
  end
end
