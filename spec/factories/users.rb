
FactoryGirl.define do
  factory :user do |f|
    f.email 'adrien@aschen.ovh'
    f.encrypted_password = Devise::Encryptor.digest(User, 'password')
  end
end
