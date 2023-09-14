module Paginable 
    protected

    def current_page
        (params[:page] || 1).to_i # params pega o ṇª da pag, se não tiver vai para a 1ª pag - aula 16 
    end
end