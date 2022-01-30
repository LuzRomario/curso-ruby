class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.all.order(:description).page(params[:page]).per(15)
  end

  def edit
  end

  def update
    if @subject.update(params_subject)
      redirect_to admins_backoffice_subjects_path, notice: "Assunto atualizado!"
        else 
      render :edit
    end
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(params_subject)
    if @subject.save
    redirect_to admins_backoffice_subjects_path, notice: "Assunto cadastrado!"
    else 
      render :new
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto excluído!"
      else 
      render :index
    end
  end
    
  private

  def params_subject
    params_subject = params.require(:subject).permit(:description)
  end
  def set_subject
    @subject = Subject.find(params[:id])
  end
end