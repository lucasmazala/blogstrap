class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy] 
  # before_action diz que antes rodar alguma action é para fazer um determinado comando. 
  def index
    @articles = Article.all
  end

  def show;  end # aula 8

  def new #cria o article vazio
    @article = Article.new
  end

  def create # pega os parâmetros para salvar 
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end  # aula 7
    

  def update 
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # aula 8 
    @article.destroy
    redirect_to root_path, status: :see_other #root_path diz para ir para a action index
  end

  private 

  def article_params 
    params.require(:article).permit(:title, :body)
  end

  def set_article 
    @article = Article.find(params[:id])
  end

end
