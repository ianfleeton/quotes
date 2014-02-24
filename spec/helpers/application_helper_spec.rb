require 'spec_helper'

describe ApplicationHelper do
  describe '#delete_button' do
    let(:category) { Category.create(name: SecureRandom.hex) }
    let(:html)     { delete_button(category) }

    it "links to the object's delete action" do
      expect(html).to include(category_path(category))
      expect(html).to include('data-method="delete"')
    end

    it "contains the title attribute 'Delete object.to_s'" do
      expect(html).to include("Delete #{category}")
    end

    it "includes a confirmation prompt" do
      expect(html).to include('data-confirm="Are you sure?"')
    end
  end
end
