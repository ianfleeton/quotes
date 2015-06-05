require 'rails_helper'

RSpec.describe QuotesController, type: :controller do
  let(:current_user) { double(User).as_null_object }
  let(:current_profile) { double(Profile).as_null_object }
  let(:quote) { double(Quote).as_null_object }

  before do
    session[:user] = 1
    allow(User).to receive(:find_by_id).and_return(current_user)
    allow(controller).to receive(:admin?).and_return(true)
    allow(Profile).to receive(:find_by_domain).and_return(current_profile)
  end

  describe "GET index" do
    it "finds all quotes belonging to the current profile" do
      expect(current_profile).to receive(:quotes)
      get "index"
    end

    it "assigns @quotes" do
      get "index"
      expect(assigns[:quotes]).to be
    end
  end

  describe "GET new" do
    it "does nothing" do
    end
  end

  describe "POST create" do
    before do
      allow(Quote).to receive(:new).and_return(quote)
    end

    it "creates a new quote" do
      expect(Quote).to receive(:new)
      post "create", {:title => ''}
    end

    it "assigns the current profile to the quote" do
      expect(quote).to receive(:profile_id=).with(current_profile.id)
      post "create", {:title => ''}
    end
  end

  describe "GET preview" do
    before do
      allow(Quote).to receive(:find).and_return(quote)
    end

    it "finds the quote" do
      expect(Quote).to receive(:find).with("1")
      get "preview", :id => "1"
    end
  end

  describe "POST send_quote" do
    let(:emailer) { double(Emailer).as_null_object }

    before do
      allow(Quote).to receive(:find).and_return(quote)
      allow(Emailer).to receive(:quote).and_return(emailer)
      allow(quote).to receive(:body).and_return("A quote")
    end

    it "finds the quote" do
      expect(Quote).to receive(:find).with("1")
      post(:send_quote, :id => "1")
    end

    it "emails the quote" do
      expect(Emailer).to receive(:quote).with(quote, anything(), anything())
      expect(emailer).to receive(:deliver)
      post(:send_quote, :id => "1")
    end
  end

  describe "DELETE destroy" do
    before do
      allow(Quote).to receive(:find).and_return(quote)
    end

    it "finds the quote" do
      expect(Quote).to receive(:find).with("1")
      delete "destroy", :id => "1"
    end

    it "redirects to the quotes index" do
      delete "destroy", :id => "1"
      expect(response).to redirect_to quotes_path
    end

    it "sets a flash[:notice] message" do
      delete "destroy", :id => "1"
      expect(flash[:notice]).to eq "Quote deleted."
    end
  end
end
