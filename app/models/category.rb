class Category < ApplicationRecord
    has_many :articles, dependent: :restrict_with_error #aula 13 53:18. soluciona problema de exclusão quando tem dependência 
    validates :name, 
    presence: true,  
    length: { minimum: 3, maximum: 15},
    uniqueness: {case_sensitive: false} # aula 17 16 min. Para uma categoria não se repetir. 

    scope :sorted, -> {order (:name)} # aula 13 44min
end
