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
      ].join ' → '
      "\r#{result}#{eol(meter)}"
      # stream.print result
      # print "\r#{done}/#{total}, avg #{average.round(3)}, remaining #{remaining}"#, percent: #{?| * (percent / 10)}> #{percent}%"
    end

    def slice(meter)
      "#{meter.done}/#{meter.total}"
    end

    def eta(meter)
      result = Time.now + meter.remaining_seconds
      "ETA #{result.strftime "%Y-%m-%d %H:%M:%S"}"
    end

    def remaining(meter)
      mm, ss = meter.remaining_seconds.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)

      "%02d:%02d:%02d" % [hh, mm, ss]
      # "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
      #=> 3 days, 3 hours, 15 minutes and 21 seconds
    end

    def eol(meter)
      meter.completed? ? "\n" : ''
    end
  end
end
