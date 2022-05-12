# coding: us-ascii
# frozen_string_literal: true
require 'rspec'
require 'stringio'

require_relative '../lib/ltsv'

module LTSV
  module RspecHelpers
  end
end

RSpec.configure do |configuration|
  configuration.include LTSV::RspecHelpers
end
