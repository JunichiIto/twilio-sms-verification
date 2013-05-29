TwilioSmsVerification::Application.routes.draw do
  resources :present_entries
  root to: 'present_entries#new'
end
