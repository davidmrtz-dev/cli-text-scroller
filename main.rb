#!/usr/bin/env ruby
require 'aasm'
require 'byebug'
require 'serialport'
require_relative './lib/application'

class RunTime
  def self.execute
    Application.setup && loop { Application.run }
  end
end

RunTime.execute
