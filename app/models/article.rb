class Article < ApplicationRecord
    belongs_to :category
    belongs_to :user

    has_many :comments, dependent: :destroy # destroy = Se o article for exluído, todos os comentários também serão. 

    validates :title, presence: true,  length: { minimum: 5, maximum: 30}
    validates :body, presence:true, length: { minimum: 10, maximum: 10000}

    paginates_per 10 # indica o número de article por página aula 12 - 32:25 min
    
    scope :desc_order, -> {order(created_at: :desc)} #aula 12 - 30min
    scope :without_highlights, ->(ids){ where("id NOT IN(#{ids})") if ids.present? } # o if é para não dar problema quando não houver posts utilizando o bd postgress aula 13 4min
    scope :filter_by_category, -> (category) {where category_id: category.id if category.present? } # aula 16 32 min(modificações) a setinha diz que a instrução será em uma linha só.
    #lambda e porque a instução será em mais de uma linha. aula 18 30 min
    scope :filter_by_archive, lambda {  |month_year|
        if month_year
            date = Date.strptime(month_year, '%B %Y')
            where created_at: date.beginning_of_month..date.end_of_month.next_day
        end
    }
end
