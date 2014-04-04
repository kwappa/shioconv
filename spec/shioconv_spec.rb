require 'spec_helper'

describe Shioconv do
  let(:invalid_condiment_name) { :invalid_condiment }
  let(:invalid_unit_name) { :invalid_unit }

  describe '.measure' do
    context 'if invalid condiment_name given' do
      specify { expect { Shioconv.measure(invalid_condiment_name, 1, :tbsp) }.to raise_error ArgumentError }
    end

    context 'if invalid unit name given' do
      specify { expect { Shioconv.measure(:salt, 1, invalid_unit_name) }.to raise_error ArgumentError }
    end
  end
end
