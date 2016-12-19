require 'spec_helper'

describe Fortschritt::Printer do
  let(:printer) { described_class.new }

  describe '#print' do
    it 'does nothing for non-tty output' do
      stream = StringIO.new
      expect { printer.print(:foo, stream) }.not_to change { stream.string }
    end
  end
end
