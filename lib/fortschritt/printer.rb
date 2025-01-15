module Fortschritt
  class Printer
    def print(meter, stream = STDOUT)
      stream.print output(meter) if stream.tty?
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

    def format_seconds(seconds)
      mm, ss = seconds.divmod(60)
      hh, mm = mm.divmod(60)
      "%02d:%02d:%02d" % [hh, mm, ss]
    end
  end
end
