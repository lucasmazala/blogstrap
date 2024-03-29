class CommentsController < ApplicationController
    before_action :authenticate_user! # para permitir criar todas as ações do comment só se o usuário estiver logado. 
    before_action :set_article 

    def create 
        @article.comments.create(comment_params.to_h.merge!({ user_id: current_user.id })) #aula 19 25 min
        redirect_to article_path(@article), notice: t('app.create.success', model: Comment.model_name.human)
    end

    def destroy 
        comment = @article.comments.find(params[:id])
        authorize comment # chama o pundit e faz a checagem se os usuários são iguais. aula 20 9 min

        comment.destroy
        redirect_to article_path(@article), notice: t('app.destroy.success', model: Comment.model_name.human)
    end
    
    private 

    def comment_params 
        params.require(:comment).permit(:body)
    end

    def set_article 
        @article = Article.find(params[:article_id]) # aula 19 20min
    end
end
