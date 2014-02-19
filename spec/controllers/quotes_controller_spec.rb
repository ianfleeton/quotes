require 'spec_helper'

describe QuotesController do
  let(:current_user) { mock_model(User).as_null_object }
  let(:current_profile) { mock_model(Profile).as_null_object }
  let(:quote) { mock_model(Quote).as_null_object }

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

  describe "POST create" do
    before do
      Quote.stub(:new).and_return(quote)
    end

    it "creates a new quote" do
      Quote.should_receive(:new)
      post "create", {:title => ''}
    end

    it "assigns the current profile to the quote" do
      quote.should_receive(:profile_id=).with(current_profile.id)
      post "create", {:title => ''}
    end
  end

  describe "GET preview" do
    before do
      Quote.stub(:find).and_return(quote)
    end

    it "finds the quote" do
      Quote.should_receive(:find).with("1")
      get "preview", :id => "1"
    end
  end

  describe "POST send_quote" do
    let(:emailer) { double(Emailer).as_null_object }

    before do
      Quote.stub(:find).and_return(quote)
      Emailer.stub(:quote).and_return(emailer)
      quote.stub(:body).and_return("A quote")
    end

    it "finds the quote" do
      Quote.should_receive(:find).with("1")
      post(:send_quote, :id => "1")
    end

    it "emails the quote" do
      Emailer.should_receive(:quote).with(quote, anything(), anything())
      emailer.should_receive(:deliver)
      post(:send_quote, :id => "1")
    end
  end

  describe "DELETE destroy" do
    before do
      Quote.stub(:find).and_return(quote)
    end

    it "finds the quote" do
      Quote.should_receive(:find).with("1")
      delete "destroy", :id => "1"
    end

    it "redirects to the quotes index" do
      delete "destroy", :id => "1"
      response.should redirect_to quotes_path
    end

    it "sets a flash[:notice] message" do
      delete "destroy", :id => "1"
      flash[:notice].should == "Quote deleted."
    end
  end
end
