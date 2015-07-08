require 'spec_helper'

describe Fortschritt::Meter do
  let(:meter) { described_class.new(4) }

  describe '#initialize' do
    it 'sets total' do
      expect(meter.total).to eq 4
    end

    it 'sets done' do
      expect(meter.done).to eq 0
    end
  end

  describe '#remaining_seconds' do
    it 'multiplys average_seconds with remaining' do
      meter.done = 2
      meter.average_seconds = 1.5
      expect(meter.remaining_seconds).to eq 3.0
    end
  end

  describe '#calculate_average_seconds' do
    it 'returns the given value if none was calculated before' do
      result = meter.calculate_average_seconds(2)
      expect(result).to eq 2
    end

    it 'calculates the right average' do
      meter.done            = 1
      meter.average_seconds = 4.0
      result                = meter.calculate_average_seconds(2)
      expect(result).to eq 3.0
    end
  end

  describe '#completed?' do
    it 'returns true if total reached' do
      meter.done = 4
      expect(meter).to be_completed
    end
  end

end
