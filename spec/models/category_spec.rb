require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_presence_of(:name) }

  describe '#to_s' do
    it 'returns its name' do
      expect(Category.new(name: 'Misc').to_s).to eq 'Misc'
    end
  end
end
