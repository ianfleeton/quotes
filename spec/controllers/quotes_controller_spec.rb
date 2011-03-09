require 'spec_helper'

describe QuotesController do
  let(:current_user) { mock_model(User).as_null_object }
  let(:current_profile) { mock_model(Profile).as_null_object }

  before do
    session[:user] = 1
    User.stub(:find_by_id).and_return(current_user)
    User.stub(:admin).and_return(true)
    Profile.stub(:find_by_domain).and_return(current_profile)
  end

  describe "GET index" do
    it "finds all quotes belonging to the current profile" do
      current_profile.should_receive(:quotes)
      get "index"
    end

    it "assigns @quotes" do
      get "index"
      assigns[:quotes].should_not be_nil
    end
  end

  describe "GET new" do
    it "does nothing" do
    end
  end

  describe "POST create"
  describe "GET preview"
  describe "GET send_or_back"
  describe "POST send_quote"
  describe "DELETE destroy"
end
