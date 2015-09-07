require 'rails_helper'

  describe ListsController do
    FactoryGirl.lint

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
        list_attributes = FactoryGirl.attributes_for(:list)
        post :create, list: list_attributes
        expect(List.last.attri)


      end
    end




  end
