require 'rails_helper'

  describe ListsController do
    factories_to_lint = FactoryGirl.factories.reject do |factory|
      factory.name =~ /^invalid_/
    end

    FactoryGirl.lint(factories_to_lint)

    def create_list
      @list = FactoryGirl.create(:list)
      @list_attributes = @list.attributes
    end

    def create_lists_and_tasks
      @list = FactoryGirl.create(:list)
      task1 = FactoryGirl.create(:task)
      task2 = FactoryGirl.create(:task)
      @list.tasks << [task2, task1]
    end

    describe '#index' do
      it 'shows all the lists' do
        get :index
        expect(assigns(:lists)).to eq(List.all)
      end

      it 'renders index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe '#new' do
      it 'assings a new list object' do
        get :new
        expect(assigns(:list)).to be_a_new(List)
      end

      it 'renders the new page' do
        get :new
        expect(response).to render_template('new')
      end
    end

    describe '#create' do

      it 'creates a new list object' do
        create_list
        post :create, list: @list_attributes
        expect(List.last.category).to eq(@list.category)
        expect(List.last.created_by).to eq(@list.created_by)
      end

      it 'redirects to route after creating' do
        create_list
        post :create, list: @list_attributes
        expect(response).to redirect_to lists_path
      end

      it 'reloads the page after failing to create' do
        list_attributes = FactoryGirl.attributes_for(:invalid_list)
        post :create, list: list_attributes
        expect(response).to redirect_to new_list_path
      end
    end

    describe '#show' do
      it 'shows a lists and its tasks' do
        create_lists_and_tasks
        get :show, id: @list.id
        expect(response).to render_template('show')
      end
    end

    describe '#edit' do
      it 'renders the edit page' do
        create_lists_and_tasks
        get :edit, id: @list.id
        expect(response).to render_template('edit')
      end
    end

    describe '#update' do

      it 'edits a list with valid parameters' do
        create_lists_and_tasks
        list_attributes = FactoryGirl.attributes_for(:list)
        put :update, id: @list.id, list: list_attributes
        expect(@list.category).to eq(list_attributes[:category])
      end

      it 'redirects to list index page after successful update' do
        create_lists_and_tasks
        list_attributes = FactoryGirl.attributes_for(:list)
        put :update, id:@list.id, list: list_attributes
        expect(response).to redirect_to(lists_path)
      end

      it 'edits a list with invalid parameters' do
        create_lists_and_tasks
        list_attributes = FactoryGirl.attributes_for(:invalid_list)
        put :update, id: @list.id, list: list_attributes
        expect(response).to redirect_to(edit_list_path(@list))
      end
    end


  end
