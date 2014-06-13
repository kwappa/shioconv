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
        expect(salt.send(superclass_method)).to be_falsey
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
      context 'from weight' do
        subject(:soy_source) { Shioconv.measure(:soy_source, 10, :g) }

        context 'to weight' do
          it 'converts correctly from g to kg' do
            expect(soy_source.to_kg).to be_within(0.01).of(0.01)
          end

          it 'converts correctly from g to oz' do
            expect(soy_source.to_oz).to be_within(0.01).of(0.3527)
          end
        end

        context 'to volume' do
          it 'converts correctly from g to tbsp' do
            expect(soy_source.to_tbsp).to be_within(0.01).of(0.5797)
          end
        end
      end

      context 'from value' do
        subject(:soy_source) { Shioconv.measure(:soy_source, 15, :cc) }

        context 'to volume' do
          it 'converts correctly from cc to tbsp' do
            expect(soy_source.to_tbsp).to be_within(0.01).of(1)
          end

          it 'converts correctly from cc to us_cup' do
            expect(soy_source.to_us_cup).to be_within(0.01).of(0.0634)
          end
        end

        context 'to weight' do
          it 'converts correctly from cc to g' do
            expect(soy_source.to_g).to be_within(0.01).of(17.25)
          end
        end
      end
    end
  end
end
