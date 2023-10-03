require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    name { 'Usuario de Prueba' }
    bio { 'Biografía de Prueba' }
    photo { 'imagen.jpg' }
    posts_counter { 0 }
  end
end

FactoryBot.define do
  factory :post do
    title { 'Título de Prueba' }
    text { 'Texto de Prueba' }
    commentsCounter { 0 }
    likesCounter { 0 }
    association :author, factory: :user
  end
end

FactoryBot.define do
  factory :comment do
    text { 'Texto de comentario de prueba' }
    created_at { 1.hour.ago }
  end
end

FactoryBot.define do
  factory :like do
    ## ---
  end
end
