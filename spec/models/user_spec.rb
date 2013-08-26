require 'spec_helper'

describe User do
  subject { User.new }

  it{ should respond_to :name }
  it{ should respond_to :email }
  it{ should respond_to :password }
  it{ should respond_to :password_confirmation }
  it{ should respond_to :password_digest }

  describe "validation" do
    context "with invalid data" do
      it "when name is empty" do
        FactoryGirl.build(:valid_user, name: "").should_not be_valid
      end

      it "when name too long" do
        FactoryGirl.build(:valid_user, name: "a" * 256).should_not be_valid
      end

      it "when email is empty" do
        FactoryGirl.build(:valid_user, email: "").should_not be_valid
      end

      it "when email has wrong format" do
        wrong_emails = %w[user@foo,com user_at_foo.com example.user@foo. foo@bar_vbaz.com foo@bar+baz.com]
        wrong_emails.each do |w_email|
          FactoryGirl.build(:valid_user, email: w_email).should_not be_valid
        end
      end

      it "when password is empty" do
        FactoryGirl.build(:valid_user, password: "").should_not be_valid
      end

      it "when password less than 6 chars" do
        FactoryGirl.build(:valid_user, password: "a" * 5).should_not be_valid
      end

      it "when password_confirmation not equal password" do
        FactoryGirl.build(:valid_user, password_confirmation: "Pa$$w0rd1").should_not be_valid
      end
    end

    context "with valid data" do
      it { FactoryGirl.build(:valid_user).should be_valid }

      it "any true email format" do
        emails = %w[user@foo.com user_at_foo@mail.com foo123@gmail.com]
        emails.each do |email|
          FactoryGirl.build(:valid_user, email: email).should be_valid
        end
      end

      it "any user name format" do
        users = %w[example@user 123user user123 I'm_valid_user]
        users.each do |user|
          FactoryGirl.build(:valid_user, name: user).should be_valid
        end
      end
    end
  end

end
