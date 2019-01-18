# frozen_string_literal: true

module Administration
  class BackOfficeController < AdministrationController
    def index
      @users = User.all
    end

    def new; end

    def create
      User.find(params[:id]).offer(params[:text])
      redirect_to administration_backoffice_path
    end
  end
end
