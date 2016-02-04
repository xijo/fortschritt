module Fortschritt
  class Printer
    def print(meter, stream = STDOUT)
      stream.print output(meter)
    end

    def output(meter)
      result = [
        slice(meter),
        remaining(meter),
        eta(meter),
        finished_after(meter),
      ].compact.join ' → '
      "\r#{result}#{eol(meter)}"
    end

    def slice(meter)
      "#{meter.done}/#{meter.total}"
    end

    def eta(meter)
      result = Time.now + meter.remaining_seconds
      "ETA #{result.strftime "%Y-%m-%d %H:%M:%S"}"
    end

    def finished_after(meter)
      meter.completed? or return
      "took #{format_seconds(meter.total_elapsed_seconds)}"
    end

    def remaining(meter)
      format_seconds meter.remaining_seconds
    end

    def eol(meter)
      meter.completed? ? "\n" : ''
    end

    private

    # "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
    #=> 3 days, 3 hours, 15 minutes and 21 seconds
    def format_seconds(seconds)
      mm, ss = seconds.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)
      "%02d:%02d:%02d" % [hh, mm, ss]
    end
  end
end
