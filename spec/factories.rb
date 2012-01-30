Factory.define :user do |f|
  f.sequence(:name) { |n| "Example#{n} User" }
  f.sequence(:uid) { |n| "12345#{n}" }
  f.provider "Twitter"
end