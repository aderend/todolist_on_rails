class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task created"
      redirect_to list_path(id: @task.list_id)
    else
      flash[:notice] = "Please enter a task name"
      redirect_to list_path(id: @task.list_id)
      # redirect_to root_path, flash: { error: "wtf mate?" }
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update(task_params)
    redirect_to list_path(id: @task.list_id)
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to list_path(id: @task.list_id)
  end

  private

  def task_params
    params.require(:task).permit(:name, :list_id)
  end

end
