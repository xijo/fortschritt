require 'fortschritt/version'
require 'fortschritt/meter'
require 'fortschritt/printer'
require 'fortschritt/enumerable'

module Fortschritt
  def self.increment(n = 1)
    @meter and @meter.increment(n)
  end

  def self.init(total, silent: false)
    @meter = Fortschritt::Meter.new(total, silent: silent)
  end

  def self.printer
    @printer ||= Fortschritt::Printer.new
  end
end
