class CategoriesController < ApplicationController
  before_action :authenticate_user! #Verifica se o usuário está logado aula 15 - 50min
  before_action :set_category, only: %i[edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = policy_scope(Category.sorted) # policy_scope é usado quando vai trazer vários registros
  end

  # GET /categories/new
  def new
    @category = Category.new
    authorize @category # authorize é usado quando traz apenas um registro
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    authorize @category # authorize manda para category_policy

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: t('app.create.success', model: Category.model_name.human) }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_url, notice: t('app.update.success', model: Category.model_name.human) }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    if @category.destroy

      respond_to do |format|
        format.html { redirect_to categories_url, notice: t('app.destroy.success', model: Category.model_name.human) } #Transform the model name into a more human format, using I18n. By default, it will underscore then humanize the class name.  https://apidock.com/rails/v5.2.3/ActiveModel/Name/human
        format.json { head :no_content }
      end
    else  
      redirect_to categories_url, alert: @category.errors.messages[:base][0]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
      authorize @category  #aula 15 1:20min
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
