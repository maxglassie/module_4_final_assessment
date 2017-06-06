require "rails_helper"

RSpec.describe Link, type: :model do
  context "validations" do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
  end

  context "url validation" do
    it "returns an error if url is invalid" do
      link = Link.new(url: "not valid", title: "invalid")
      link.save
      expect(link.errors.messages[:url][0]).to eq("is not a valid HTTP URL")
    end
  end
end