require 'rails_helper'

  describe ListsController do
    factories_to_lint = FactoryGirl.factories.reject do |factory|
      factory.name =~ /^invalid_/
    end

    FactoryGirl.lint(factories_to_lint)

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
        list = FactoryGirl.create(:list)
        list_attributes = list.attributes
        post :create, list: list_attributes
        expect(List.last.category).to eq(list.category)
        expect(List.last.created_by).to eq(list.created_by)
      end

      it 'redirects to route after creating' do
        list = FactoryGirl.create(:list)
        list_attributes = list.attributes
        post :create, list: list_attributes
        expect(response).to redirect_to lists_path
      end

      it 'reloads the page after failing to create' do
        # list = FactoryGirl.create(:invalid_list)
        list_attributes = FactoryGirl.attributes_for(:invalid_list)
        post :create, list: list_attributes
        expect(response).to redirect_to new_list_path
      end
    end

    describe '#show' do
      it 'It shows a lists and its tasks' do
        list = FactoryGirl.create(:list)
        task1 = FactoryGirl.create(:task)
        task2 = FactoryGirl.create(:task)
        list.tasks << [task2, task1]
        get :show, id: list.id
        expect(response).to render_template('show')
      end
    end

    describe '#edit' do
      it 'renders the edit page' do
        list = FactoryGirl.create(:list)
        task1 = FactoryGirl.create(:task)
        task2 = FactoryGirl.create(:task)
        list.tasks << [task2, task1]
        get :edit, id: list.id
        expect(response).to render_template('edit')
      end

      it 'edits a list' do
        list = FactoryGirl.create(:list)
        task1 = FactoryGirl.create(:task)
        task2 = FactoryGirl.create(:task)
        list.tasks << [task2, task1]
        list_attributes = FactoryGirl.attributes_for(:list)
        put :update, id: list.id, list: list_attributes
        expect(list.category).to eq(list_attributes[:category])
      end
    end


  end
