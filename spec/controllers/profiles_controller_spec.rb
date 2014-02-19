require 'spec_helper'

describe ProfilesController do
  let(:current_profile) { mock_model(Profile).as_null_object }

  before do
    Profile.stub(:find_by_domain).and_return(current_profile)
    controller.stub(:admin?).and_return(true)
  end

  describe 'GET index' do
    it 'succeeds' do
      get :index
      expect(response).to be_successful
    end
  end
end
