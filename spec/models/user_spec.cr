require "./spec_helper"
require "../../src/models/user.cr"
require "json"

describe User do
  Spec.before_each do
    User.clear
  end

  valid_attributes = {
    "email" => "mail@hoogle.nom",
    "username" => "fishcalledhank",
    "encrypted_password" => "abcd1adsfasdf234",
    "first_name" => "marie",
    "last_name" => "boer",
    "infix" => "de"
  }

  describe "#save" do
    it "should save a valid user" do
      user = User.new(valid_attributes)
      user.save

      user.id.should_not be_nil
    end

    it "should set the admin to false" do
      user = User.new(valid_attributes)
      user.save

      user.admin.should be_false
    end
  end

  describe "validations" do
    it "should be valid with valid attributes" do
      user = User.new
      user.set_attributes valid_attributes
      user.valid?.should be_true

      user.save
    end

    it "should be invalid with invalid attributes" do
      user = User.new
      user.set_attributes({
        "email" => "mail@hoogle",
        "username" => "f",
        "encrypted_password" => "asdfasdfabcd123",
        "first_name" => "m",
        "last_name" => "b"
      })

      user.valid?.should be_false
      user.errors.size.should eq(4)
    end
  end

  describe "#password" do
    it "should encrypt the password" do
      user = User.new(valid_attributes)
      user.password = "abcd1234"
      user.encrypted_password.should_not eq("abcd1234")
    end

    it "should authenticate the user" do
      user = User.new(valid_attributes)
      user.password = "abcd1234"
      user.save

      match = user.authenticate("abcd1234")
      match.should be_true
    end
  end

  describe "#to_json" do
    it "should return all fields except password" do
      user = User.new(valid_attributes).to_json
      user = JSON.parse(user).as_h

      user.fetch("email").should eq("mail@hoogle.nom")
      user.fetch("password", nil).should be_nil
      user.fetch("encrypted_password", nil).should be_nil
    end
  end
end
