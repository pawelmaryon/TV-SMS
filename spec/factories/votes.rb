FactoryBot.define do
  factory :vote do
    campaign { nil }
    validity { "MyString" }
    choice { "MyString" }
    conn { "MyString" }
    msisdn { "MyString" }
    guid { "MyString" }
    shortcode { "MyString" }
  end
end
