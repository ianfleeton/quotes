require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:current_profile) { double(Profile).as_null_object }

  before do
    allow(Profile).to receive(:find_by_domain).and_return(current_profile)
    allow(controller).to receive(:admin?).and_return(true)
  end

  describe 'GET index' do
    it 'succeeds' do
      get :index
      expect(response).to be_successful
    end
  end
end
