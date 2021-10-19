require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

  let(:category) {
    Category.new(:name=> "Electronics")
  }
  subject {
    described_class.new(name: "Modern Skateboards",
                        description: "Some description of skates",
                        price: 50,
                        quantity: 3,
                        category: category)
  }

  
    it "should validate that name is present" do
      expect(subject).to be_valid
    end

    context 'requires name' do
      it 'has name' do
        subject.name = nil
        subject.valid?
        expect(subject.errors[:name]).to  include("can't be blank")
      end
    end
  end
end
