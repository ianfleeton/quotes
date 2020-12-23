require "rails_helper"

RSpec.describe "Profiles", type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:admin?).and_return true
    allow(Profile).to receive(:find_by_domain).and_return(FactoryBot.build(:profile))
  end

  describe "PATCH /profiles/:id" do
    let(:profile) { FactoryBot.create(:profile) }

    it "updates the profile" do
      patch profile_path(profile.id, params: {profile: {name: "New profile"}})
      profile.reload
      expect(profile.name).to eq "New profile"
    end
  end
end
