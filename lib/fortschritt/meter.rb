module Fortschritt
  class Meter
    attr_accessor :total, :done, :updated_at, :average_seconds, :silent

    def initialize(total, silent: false)
      @total           = total
      @done            = 0
      @updated_at      = Time.now
      @average_seconds = 0
      @started_at      = Time.now
      @silent          = silent || !!(Rails.env.test? if defined?(Rails))
      @printed_at      = Time.now
    end

    def increment
      @_now            = Time.now
      elapsed_seconds  = @_now - updated_at
      @average_seconds = calculate_average_seconds(elapsed_seconds)
      @updated_at      = @_now
      @done           += 1
      print! unless @silent || debounce?
    end

    def completed?
      done >= total
    end

    def remaining_seconds
      remaining * average_seconds
    end

    def remaining
      [total - done, 0].max
    end

    def calculate_average_seconds(value)
      average_seconds.zero? and return value
      ((average_seconds * done) + value) / (done + 1)
    end

    def total_elapsed_seconds
      Time.now - @started_at
    end

    def print!
      Fortschritt.printer.print(self)
    end

    def debounce?
      return true if @updated_at - @printed_at < 0.01 && !completed?

      @printed_at = @updated_at
      false
    end
  end
end
