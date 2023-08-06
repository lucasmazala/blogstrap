module ArticlesHelper
    def month_day_comma_year(datetime) # formata o modo de exibição da data
        datetime.strftime('%B %e, %Y')
    end
end
# aula 10 37:00 min 