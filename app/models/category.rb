class Category < ApplicationRecord
    has_many :articles, dependent: :restrict_with_error #aula 13 53:18. soluciona problema de exclusão quando tem dependência 
    validates :name, presence: true,  length: { minimum: 3, maximum: 15}
    
    scope :sorted, -> {order (:name)} # aula 13 44min
end
