Factory.define :user do |user|
  user.name			"Example User"
  user.uid			"12345"
  user.provider 	:twitter
end

Factory.define :consideration do |consideration|
  consideration.content "Foo bar"
  consideration.association :user
end