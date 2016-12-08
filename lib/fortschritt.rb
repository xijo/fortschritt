require 'fortschritt/version'
require 'fortschritt/meter'
require 'fortschritt/printer'
require 'fortschritt/enumerable'

module Fortschritt
  def self.increment
    @meter and @meter.increment
  end

  def self.init(total, opts = {})
    @meter = Fortschritt::Meter.new(total, opts)
  end

  def self.printer
    @printer ||= Fortschritt::Printer.new
  end
end
