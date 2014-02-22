require 'spec_helper'

describe ItemsController do
  let(:current_profile) { mock_model(Profile).as_null_object }

  before do
    Profile.stub(:find_by_domain).and_return(current_profile)
  end

  describe 'PATCH update' do
    context 'as admin' do
      before { controller.stub(:admin?).and_return(true) }

      it 'updates the given item' do
        item = Item.create!(name: 'Widget', information: '')
        new_name = SecureRandom.hex
        patch :update, id: item.id, item: { name: new_name }
        expect(Item.find(item.id).name).to eq new_name
      end
    end
  end
end
