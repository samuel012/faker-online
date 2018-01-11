Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :api_base do
    valid_constants = Faker.constants - %i(Config Base VERSION Char UniqueGenerator)

    valid_constants.each do |c|
      get c.downcase, to: "data_generator#show"
      Faker.const_get(c).methods(false).each do |m|
        get c.to_s.downcase + "/" + m.to_s.downcase, to: "data_generator#show"
      end
    end
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end
  
end
