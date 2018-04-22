class EmailsController < ApplicationController
  before_action do
    only :create {
      case email_params.validate!["type"]
      when "employment" then employment_conditions_params.validate!
      when "freelance" then freelance_conditions_params.validate!
      end
    }
  end

  def create
    email = Email.new(email_params.to_h)
    email.save

    halt!(422, email.errors.first.message) if email.errors.any?

    respond_with { json({ "status" => 200 }.to_json) }
  end

  private def create!
    email = Email.new(email_params)
    email.save
  end

  private def email_params
    params.validation do
      required(:body) { |p| !p.nil? }
      required(:from_email) { |p| !p.nil? }
      required(:from_name) { |p| !p.nil? }
      required(:title) { |p| !p.nil? }
      required(:type) { |p| ["freelance", "employment"].includes? params[:type] }
      required(:user_id) { |p| !p.nil? }
    end
  end

  private def employment_conditions_params
    params.validation do
      required(:fixed_annual_bonus) { |p| !p.nil? }
      required(:monthly_wage_high) { |p| !p.nil? }
      required(:monthly_wage_low) { |p| !p.nil? }
      required(:pension_compensation) { |p| !p.nil? }
      required(:thirteenth_month) { |p| !p.nil? }
      required(:vacation_days) { |p| !p.nil? }
      required(:variable_annual_bonus) { |p| !p.nil? }
      required(:wage_indexation) { |p| !p.nil? }
    end
  end

  private def freelance_conditions_params
    params.validation do
      required(:hourly_fee_high) { |p| !p.nil? }
      required(:hourly_fee_low) { |p| !p.nil? }
      required(:hours) { |p| !p.nil? }
    end
  end
end
