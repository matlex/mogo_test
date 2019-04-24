require 'minitest/autorun'
require 'minitest/spec'

require_relative 'checkout'

describe Checkout do
  subject { Checkout.new(pricing_rules) }
  let(:pricing_rules) {
    {"CC": {
      discount_percent: 100,
      condition: ">",
      condition_quantity: 1,
      apply_for_all_items: false
    },
     "PC": {
       discount_percent: 20,
       condition: ">=",
       condition_quantity: 3,
       apply_for_all_items: true
     }
    }
  }

  it 'must have a total' do
    subject.must_respond_to 'total'
  end

  it 'should have an add method' do
    subject.must_respond_to 'add'
  end

  it 'should add CC - Coca Cola and return total' do
    subject.add('CC')
    subject.total.must_equal "$1.50"
  end

  it 'should add CC PC WA and return total' do
    %w(CC PC WA).each { |item| subject.add(item) }
    subject.total.must_equal "$4.35"
  end

  it 'should add CC PC CC CC and return total' do
    %w(CC PC CC CC).each {|item| subject.add(item)}
    subject.total.must_equal "$5.00"
  end

  it 'should add PC CC PC WA PC CC and return total' do
    %w(PC CC PC WA PC CC).each {|item| subject.add(item)}
    subject.total.must_equal "$7.15"
    end
end
