# coding: us-ascii
require 'rspec'
require 'stringio'

require_relative '../lib/ltsv'

module LTSV::RspecHelpers
end

RSpec.configure do |configuration|
  configuration.include LTSV::RspecHelpers
end
