class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show] # aula 14 - 18 min
  before_action :set_article, only: %i[show edit update destroy] 
  # before_action diz que antes rodar alguma action é para fazer um determinado comando. 
  def index
    @highlights = Article.desc_order.first(3)# traz os 3 artigos mais recentes.
    
    current_page = (params[:page] || 1).to_i # params pega o ṇª da pag, se não tiver vai para a 1ª pag
    highlights_ids = @highlights.pluck(:id).join(',') # separa os 3 primeiros IDS. Eles só serão exibidos nos highlights
    
    @articles = Article.without_highlights(highlights_ids) #organização aula 12 - 30min 
                       .desc_order    
                       .page(current_page) #usando kaminari para paginação.  aula 11 - 9:52 - https://github.com/kaminari/kaminari
  end

  def show;  end # aula 8

  def new #cria o article vazio
    @article = current_user.articles.new
  end

  def create # pega os parâmetros para salvar 
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end  # aula 7
    

  def update 
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # aula 8 
    @article.destroy
    redirect_to root_path, status: :see_other ,  notice: "Article was successfully destroyed." #root_path diz para ir para a action index
  end

  private 

  def article_params 
    params.require(:article).permit(:title, :body, :category_id)
  end

  def set_article 
    @article = Article.find(params[:id])
  end

end
