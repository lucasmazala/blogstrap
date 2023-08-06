class Article < ApplicationRecord
    validates :title, presence: true,  length: { minimum: 5, maximum: 30}
    validates :body, presence:true, length: { minimum: 10, maximum: 10000}

    paginates_per 2 # indica o número de article por página aula 12 - 32:25 min
    
    scope :desc_order, -> {order(created_at: :desc)} #aula 12 - 30min
    scope :without_highlights, ->(ids){ where("id NOT IN(#{ids})" ) }
end
