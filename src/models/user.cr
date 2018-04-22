require "crypto/bcrypt/password"

class User < Granite::ORM::Base
  adapter pg
  table_name users

  field infix : String
  field admin : Bool
  field email : String
  field encrypted_password : String
  field first_name : String
  field last_name : String
  field username : String

  primary id : Int64

  timestamps

  has_many :emails
  has_many :employment_conditions, through: :emails
  has_many :freelance_conditions, through: :emails

  before_save :strip_and_downcase
  before_create :fill_in_default_values

  # 1. Take a deep breath
  # 2. Close your eyes
  # 3. Scroll 30 lines down without looking

  validate :first_name, MIN_LENGTH_MESSAGE, ->(self : User)
    { !self.first_name.nil? && self.first_name != "" && self.first_name.not_nil!.size >= MIN_LENGTH }
  validate :first_name, MAX_LENGTH_MESSAGE, ->(self : User)
    { !self.first_name.nil? && self.first_name != "" && self.first_name.not_nil!.size <= MAX_LENGTH }
  validate :first_name, REQUIRED_MESSAGE, ->(self : User)
    { (first_name = self.first_name) ? !first_name.empty? : false }

  validate :last_name, MIN_LENGTH_MESSAGE, ->(self : User)
    { !self.last_name.nil? && self.last_name != "" && self.last_name.not_nil!.size >= MIN_LENGTH }
  validate :last_name, MAX_LENGTH_MESSAGE, ->(self : User)
    { !self.last_name.nil? && self.last_name != "" && self.last_name.not_nil!.size <= MAX_LENGTH }
  validate :last_name, REQUIRED_MESSAGE, ->(self : User)
    { (last_name = self.last_name) ? !last_name.empty? : false }

  validate :username, MIN_LENGTH_MESSAGE, ->(self : User)
    { !self.username.nil? && self.username != "" && self.username.not_nil!.size >= MIN_LENGTH }
  validate :username, MAX_LENGTH_MESSAGE, ->(self : User)
    { !self.username.nil? && self.username != "" && self.username.not_nil!.size <= MAX_LENGTH }
  validate :username, REQUIRED_MESSAGE, ->(self : User)
    { (username = self.username) ? !username.empty? : false }

  validate :email, MAX_LENGTH_MESSAGE, ->(self : User)
    { !self.email.nil? && self.email != "" && self.email.not_nil!.size <= MAX_LENGTH }
  validate :email, "is not an e-mail address", ->(self : User)
    { (email = self.email) ? email.email? : false }

  validate :infix, MAX_LENGTH_MESSAGE, ->(self : User)
    { self.infix.nil? || !self.infix.nil? && self.infix != "" && self.infix.not_nil!.size <= MAX_LENGTH }

  def password=(password)
    raise "Too short!" if password.size < 8

    self.encrypted_password = Crypto::Bcrypt::Password.create(password, cost: 10).to_s
  end

  def authenticate(password : String)
    if encrypted = self.encrypted_password
      bcrypt_password = Crypto::Bcrypt::Password.new(encrypted)
      bcrypt_password == password
    else
      false
    end
  end

  def to_json
    {
      "email" => email,
      "first_name" => first_name,
      "last_name" => last_name,
      "admin" => admin,
      "infix" => infix
    }.to_json
  end

  private def fill_in_default_values
    self.admin = false
  end

  private def strip_and_downcase
    if email = @email
      email.strip.downcase
    end
  end
end
