module ApplicationHelper
    #IMPORTANTE.  Método para caso não tenha nenhum article criado, não quebrar o sistema. Aula 12 - 21:00
    def render_if(condition, template, record)
        render template, record if condition 
    end
end
