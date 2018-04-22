class UsersController < ApplicationController
  before_action do
    only :create { create_params.validate! }
    only :authenticate { authenticate_params.validate! }
  end

  def create
    user = User.new create_params.to_h
    user.password = create_params[:password]
    user.save

    if !user.valid?
      halt!(422, "User invalid")
    else
      respond_with { json user.to_json }
    end
  end

  def authenticate
    user = User.find_by(:email, authenticate_params[:email])

    if !user.nil? && user.authenticate(authenticate_params[:password])
      respond_with { json user.to_json }
    else
      halt!(401, "Invalid email or password")
    end
  end

  private def create_params
    params.validation do
      optional(:infix) { |p| valid_string? p }
      required(:email) { |p| valid_string? p }
      required(:first_name) { |p| valid_string? p }
      required(:last_name) { |p| valid_string? p }
      required(:password) { |p| valid_string? p }
      required(:username) { |p| valid_string? p }
    end
  end

  private def authenticate_params
    params.validation do
      required(:email) { |p| valid_string? p }
      required(:password) { |p| valid_string? p }
    end
  end
end
