FactoryBot.define do
  factory :plan do
    name { 'pro' }
    to_create do |instance|
      instance.attributes = Plan.find_or_create_by(name: instance.name).attributes
      instance.instance_variable_set('@new_record', false)
    end
  end
end
