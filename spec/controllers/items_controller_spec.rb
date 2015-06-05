require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:current_profile) { double(Profile).as_null_object }

  before do
    allow(Profile).to receive(:find_by_domain).and_return(current_profile)
  end

  describe 'PATCH update' do
    context 'as admin' do
      before { allow(controller).to receive(:admin?).and_return(true) }

      it 'updates the given item' do
        item = Item.create!(name: 'Widget', information: '')
        new_name = SecureRandom.hex
        patch :update, id: item.id, item: { name: new_name }
        expect(Item.find(item.id).name).to eq new_name
      end
    end
  end
end
