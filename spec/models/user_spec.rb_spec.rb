require 'rails_helper'

RSpec.describe User, type: :model do

    subject {
      described_class.new(name: "John Doe",
                          email: "john.doe@email.com",
                          password: 'secretpass',
                          password_confirmation: 'secretpass')
    }

  describe 'Validations' do

  context "checks class" do
    it "should validate that our class here saves successfully" do
      expect(subject).to be_valid
    end
  end

  it "should validate name" do
    expect(subject.errors[:name]).not_to include("can't be blank") 
    subject.name = nil
    subject.validate
    expect(subject.errors[:name]).to include("can't be blank") 
    end

  it "should validate email" do
  expect(subject.errors[:email]).not_to include("can't be blank") 
  subject.email = nil
  subject.validate
  expect(subject.errors[:email]).to include("can't be blank") 
  end

  it "should validate password confirmation" do
    expect(subject.errors[:password]).not_to include("can't be blank") 
    subject.password = 'secretpass'
    subject.password_confirmation = 'notsosecretpass'
    subject.validate
    expect(subject.errors[:password_confirmation]).to be_present
    end

    it "should check for unique email" do
      subject.save!
      user = User.new(
        name: "Jane Doe",
        email: 'john.doe@email.com',
        password: "notsosecretpass", 
        password_confirmation: "notsosecretpass"
      )
      user.validate
      expect(user.errors.full_messages).to include('Email has already been taken')
    end

    it 'should validate password length' do
      expect(subject).to be_valid
      subject.password = 'short'
      expect(subject).to be_invalid
    end



    describe '#authenticate_with_credentials' do
      it 'should return user if email/password is correct' do
        subject.save!
        user = subject.authenticate_with_credentials('john.doe@email.com', 'secretpass')
        expect(user).not_to be(nil)
      end
      it "shouldn't return user if email/password isn't correct" do 
        user = subject.authenticate_with_credentials('john.doe@email.com', 'notsecret')
        expect(user).to be(nil)
      end

      it "should pass if user types in wrong case for email" do
        subject.save!
        user = subject.authenticate_with_credentials('john.DOE@email.com', 'secretpass')
        expect(user).not_to be(nil)
      end

      it "should pass if user accidetally adds spaces before or after email" do
        subject.save!
        user = subject.authenticate_with_credentials(' john.DOE@email.com ', 'secretpass')
        expect(user).not_to be(nil)
      end

    end
  end
end
