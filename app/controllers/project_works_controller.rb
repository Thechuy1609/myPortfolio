class ProjectWorksController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @work = @project.works.build
  end
end
