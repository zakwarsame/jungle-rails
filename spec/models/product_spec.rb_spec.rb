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

  
    it "should validate that our class here saves successfully" do
      expect(subject).to be_valid
    end

    context 'requires name' do
      it 'should validate that name is present' do
        subject.name = nil
        subject.valid?
        expect(subject.errors.full_messages).to  include("Name can't be blank")
      end
    end

    context 'requires price' do
      it 'should have price_cents' do
        subject.price_cents = nil
        subject.valid?
        expect(subject.errors[:price_cents]).to  include('is not a number')
  
        subject.price_cents = 1000
        subject.valid?
        expect(subject.errors[:price_cents]).not_to  include("can't be blank")
      end
    end

    context 'requires quantity' do
      it 'should have quantity' do
        subject.quantity = nil
        subject.valid?
        expect(subject.errors[:quantity]).to include("can't be blank")

        subject.quantity = 10
        subject.valid?
        expect(subject.errors[:quantity]).not_to include("can't be blank")
      end
    end

    context 'requires category' do
      it 'should have category' do
        subject.category = nil
        subject.valid?
        expect(subject.errors[:category]).to include("can't be blank")

        subject.category = category
        subject.valid? 
        expect(subject.errors[:category]).not_to  include("can't be blank")
      end
    end

  end
end
