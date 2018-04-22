require "./spec_helper"
require "../../src/models/email.cr"

describe Email do
  Spec.before_each do
    Email.clear
  end
end
