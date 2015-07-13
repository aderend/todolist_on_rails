class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path
    else
      redirect_to new_list_path
    end
  end

  def show
    @list = List.find_by_id(params[:id])
    @tasks = @list.tasks.order("created_at asc")
    @task = Task.new
    @id = params[:id]
  end

  def edit
    @list = List.find_by(id: params[:id])
  end

  def update
     @list = List.find_by(id: params[:id])
     @list.update(user_params)
     redirect_to lists_path
  end

  def destroy
    @list = List.find_by(id: params[:id])
    @list.destroy
    redirect_to lists_path
  end



  private

  def list_params
    params.require(:list).permit(:category, :created_by)
  end


end
