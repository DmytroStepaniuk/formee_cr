class EmploymentConditions < Granite::ORM::Base
  adapter pg
  table_name employment_conditions

  primary id : Int64
  field email_id : Int64
  field fixed_annual_bonus : Float32
  field thirteenth_month : Bool
  field vacation_days : Int16
  field variable_annual_bonus : Float32
  field wage_indexation : Bool
  field monthly_wage_high : Float32
  field monthly_wage_low : Float32
  field pension_compensation : Float32

  timestamps

  belongs_to :email

  validate :thirteenth_month, "should be either true or false" do |self|
    self.thirteenth_month.is_a? Bool
  end

  validate :vacation_days, "should be bigger than 10" do |self|
    if vacation_days = self.vacation_days
      vacation_days > 10
    else
      false
    end
  end

  validate :monthly_wage_low, "should be bigger than 500" do |self|
    if monthly_wage_low = self.monthly_wage_low
      monthly_wage_low > 500
    else
      false
    end
  end

  validate :monthly_wage_high, "should be bigger than minimum" do |self|
    if monthly_wage_high = self.monthly_wage_high && (monthly_wage_low = self.monthly_wage_low)
      monthly_wage_high >= monthly_wage_low
    else
      false
    end
  end

  validate :wage_indexation, "should be either true or false" do |self|
    self.wage_indexation.is_a? Bool
  end
end
