Factory.define :user do |user|
  user.name			"Example User"
  user.uid			"12345"
  user.provider 	:twitter
end

Factory.sequence :name do |n|
	"person-#{n}"
end

Factory.sequence :uid do |n|
	"12345#{n}"
end

Factory.define :consideration do |consideration|
  consideration.content "Foo bar"
  consideration.association :user
end

Factory.sequence :content do |n|
	"Foo bar-#{n}"
end