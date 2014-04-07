require 'spec_helper'

describe Shioconv::Unit do
  let(:convertable_unit) { :g }
  let(:not_convertable_unit) { :not_convertable_unit }

  describe '.convertable?' do
    context 'when convertable unit given' do
      specify { expect(described_class.convertable?(convertable_unit)).to be_true }
    end

    context 'when not convertable unit given' do
      specify { expect(described_class.convertable?(not_convertable_unit)).to be_false }
    end
  end

  describe '.list' do
    specify { expect(described_class.list).to be_an Array }
  end
end
