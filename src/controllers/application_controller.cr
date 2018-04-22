require "jasper_helpers"

class ApplicationController < Amber::Controller::Base
  include JasperHelpers
  LAYOUT = "application.ecr"

  def valid_string?(string)
    string != nil &&
    string.is_a? String
  end
end
