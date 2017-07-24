class FullsubmissionsController < ApplicationController
    include AdminsHelper
    before_action :admin?




    def index
        
        #debugger
        @accession=params[:accession]
        @fullsubmissions=Array.new
        Fullsubmission.all.each do |submission|
            if submission.fullquestion.ds_accession==@accession
                @name=submission.fullquestion.ds_name
                @fullsubmissions << submission
            end
        end
        
    end
    








end