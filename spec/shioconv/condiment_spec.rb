require 'spec_helper'

describe Shioconv::Unit do
  describe '.list' do
    specify { expect(described_class.list).to be_an Array }
  end
end
