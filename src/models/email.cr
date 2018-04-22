require "../patches/granite"

class Email < Granite::ORM::Base
  adapter pg
  table_name emails

  field body : String
  field from_email : String
  field from_name : String
  field sent_at : Time
  field title : String
  field user_id : Int64

  primary id : Int64

  timestamps

  belongs_to :user

  before_save :strip_and_downcase
  before_create :fill_in_default_values

  private def strip_and_downcase
    if from_email = @from_email
      from_email.strip.downcase
    end
  end

  private def fill_in_default_values
    self.sent_at = Time.now
  end
end
