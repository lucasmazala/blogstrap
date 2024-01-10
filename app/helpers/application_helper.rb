module ApplicationHelper

    def month_day_comma_year(value) # formata o modo de exibição da data
        l(value, format:'%B %e, %Y').capitalize #aula 25 44min  e aula 26 49min
    end # aula 10 37:00 min  e aula 22 13 min

    def month_year(value)
        l(value.to_datetime, format:'%B %Y').capitalize #aula 26 49min 
    end 

    #IMPORTANTE.  Método para caso não tenha nenhum article criado, não quebrar o sistema. Aula 12 - 21:00
    def render_if(condition, template, record)
        render template, record if condition 
    end

    def sub_masked_email(email)
        email.gsub(/(?<=.{2}).*@.*(?=\S{2})/, '****@****') #aula 22 4min
    end

end

