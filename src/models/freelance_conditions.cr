class FreelanceConditions < Granite::ORM::Base
  adapter pg
  table_name freelance_conditions

  primary id : Int64
  field email_id : Int64
  field hourly_fee_low : Float32
  field hourly_fee_high : Float32
  field hours : Int8

  timestamps

  belongs_to :email

  validate :hourly_fee_low, "should be greater than 17" do |self|
    if hourly_fee_low = self.hourly_fee_low
      hourly_fee_low > 17
    else
      false
    end
  end

  validate :hourly_fee_high, "should be equal or greater than the minimum" do |self|
    if hourly_fee_low = self.hourly_fee_low && (hourly_fee_high = self.hourly_fee_high)
      hourly_fee_high >= hourly_fee_low
    else
      false
    end
  end

  validate :hours, "should be greater than 0" do |self|
    if hours = self.hours
      hours > 0
    else
      false
    end
  end

  validate :email_id, "should belong to an e-mail" do |self|
    if email_id = self.email_id
      true
    else
      false
    end
  end
end
