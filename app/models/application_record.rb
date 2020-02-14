class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  Refile.secret_key = '4769bf095da1f95f449fc9470174f3a73c2f9645138bce2bdb5cb8e3dadfb8b2a2bf89a3b0af6178308565d4224f97f226fdf46e08e5238a24511faece58ef77'
end
