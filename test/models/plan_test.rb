require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  test 'plan name basic is valid' do
    plan = build(:plan, name: 'pro')
    assert(plan.valid?)
  end

  test 'plan name pro is valid' do
    plan = build(:plan, name: 'basic')
    assert(plan.valid?)
  end

  test 'plan name duplicate is invalid' do
    create(:plan, name: 'basic')
    plan = build(:plan, name: 'basic')

    assert(plan.invalid?)
  end
end
