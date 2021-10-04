class Country < ApplicationRecord
  update_index('countries') { self }
end