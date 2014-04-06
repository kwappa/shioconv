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

  describe '#method_missing' do
    subject(:salt) { Shioconv.measure(:salt, 1, :tbsp) }

    shared_examples 'does not define instance method' do
      it 'does not define instance method' do
      expect(described_class.instance_methods(false)).to_not be_include(superclass_method)
      end
    end

    context 'when called method that does not start with "to_"' do
      let(:superclass_method) { :frozen? }
      include_examples 'does not define instance method'
      it 'delegates to superclass' do
        expect(salt.send(superclass_method)).to be_false
      end
    end

    context 'when called metod that starts with "to_" but not defined at self' do
      let(:superclass_method) { :to_s }
      include_examples 'does not define instance method'
      it 'delegates to superclass' do
        expect(salt.send(superclass_method)).to be_a(String)
      end
    end

    context 'when called method that does not start with "to_" and not defined at all' do
      let(:superclass_method) { :invalid_method_name }
      include_examples 'does not define instance method'
      it 'raises NoMethodError' do
        expect { salt.send(superclass_method) }.to raise_error NoMethodError
      end
    end

    context 'when called method that starts with "to_" and not defined at all' do
      let(:superclass_method) { :to_invalid_method_name }
      include_examples 'does not define instance method'
      it 'raises NoMethodError' do
        expect { salt.send(superclass_method) }.to raise_error NoMethodError
      end
    end

    context 'when called convertable method' do
      let(:convert_method) { :to_g }
      it 'converts unit correctly' do
        expect(salt.send(convert_method)).to eq :g
      end
    end
  end
end
