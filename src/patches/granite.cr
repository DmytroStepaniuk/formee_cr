module Granite::ORM::Base::CustomConstants
  macro included
    MIN_LENGTH = 2
    MAX_LENGTH = 50

    MIN_LENGTH_MESSAGE = "too short!"
    MAX_LENGTH_MESSAGE = "too long!"
    REQUIRED_MESSAGE = "is required"
  end
end

class Granite::ORM::Base
  include Granite::ORM::Base::CustomConstants
end
