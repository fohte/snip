require 'spec_helper'

RSpec.describe Snip::Naming do
  let(:naming) { Snip::Naming.new(name) }

  describe '#normalize' do
    let(:name) { 'test' }
    subject { naming.normalize }
    it { is_expected.to eq 'test' }

    context 'with an extension' do
      let(:name) { 'test.rb' }
      it { is_expected.to eq 'test' }
    end

    context 'with extensions' do
      let(:name) { 'test.rb.erb' }
      it { is_expected.to eq 'test' }
    end

    context 'with a group' do
      let(:name) { 'group:test' }
      it { is_expected.to eq 'group:test' }
    end

    context 'with groups' do
      let(:name) { 'group1:group2:test' }
      it { is_expected.to eq 'group1:group2:test' }
    end

    context 'with a group including dots' do
      let(:name) { 'group.rb:test' }
      it { is_expected.to eq 'group.rb:test' }
    end

    context 'with a group separator and an extension' do
      let(:name) { 'group:test.rb' }
      it { is_expected.to eq 'group:test' }
    end
  end

  describe '#normalized?' do
    let(:name) { 'test' }
    subject { naming.normalized? }
    it { is_expected.to be true }

    context 'with an extension' do
      let(:name) { 'test.rb' }
      it { is_expected.to be false }
    end

    context 'with extensions' do
      let(:name) { 'test.rb.erb' }
      it { is_expected.to be false }
    end

    context 'with a group' do
      let(:name) { 'group:test' }
      it { is_expected.to be true }
    end

    context 'with groups' do
      let(:name) { 'group1:group2:test' }
      it { is_expected.to be true }
    end

    context 'with a group including dots' do
      let(:name) { 'group.rb:test' }
      it { is_expected.to be true }
    end

    context 'with a group separator and an extension' do
      let(:name) { 'group:test.rb' }
      it { is_expected.to be false }
    end
  end
end
