module ApplicationHelper

    def month_day_comma_year(datetime) # formata o modo de exibição da data
        datetime.strftime('%B %e, %Y') 
    end # aula 10 37:00 min  e aula 22 13 min

    #IMPORTANTE.  Método para caso não tenha nenhum article criado, não quebrar o sistema. Aula 12 - 21:00
    def render_if(condition, template, record)
        render template, record if condition 
    end

    def sub_masked_email(email)
        email.gsub(/(?<=.{2}).*@.*(?=\S{2})/, '****@****') #aula 22 4min
    end

end

