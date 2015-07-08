module Fortschritt
  class Meter
    attr_accessor :total, :done, :updated_at, :average_seconds

    def initialize(total)
      @total           = total
      @done            = 0
      @updated_at      = Time.now
      @average_seconds = 0
    end

    def increment
      @_now            = Time.now
      elapsed_seconds  = @_now - updated_at
      @average_seconds = calculate_average_seconds(elapsed_seconds)
      @updated_at      = @_now
      @done           += 1
      print!
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

    def print!
      Fortschritt.printer.print(self)
    end

  end
end
