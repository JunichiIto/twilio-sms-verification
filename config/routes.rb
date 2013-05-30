TwilioSmsVerification::Application.routes.draw do
  resources :present_entries do
    get 'verification_code_input'
    put 'verification'
  end
  root to: 'present_entries#new'
end
