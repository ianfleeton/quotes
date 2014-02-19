require 'spec_helper'

describe 'items/index.html.erb' do
  before do
    assign(:current_profile, Profile.new)
  end

  context 'with categories' do
    it 'links to new item' do
      render
      expect(rendered).to have_selector new_item_link
    end
  end

  context 'with no categories' do
    it 'displays a warning' do
      render
      expect(rendered).to have_content I18n.t('items.index.no_categories')
    end

    it 'does not link to new item' do
      render
      expect(rendered).not_to have_selector new_item_link
    end
  end

  def new_item_link
    "a[href='#{new_item_path}']"
  end
end
