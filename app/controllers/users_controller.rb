require 'neatjson'
require 'json'

  class UsersController < ApplicationController
    #before_filter :authenticate_admin

    def new_user
      render 'users/create_user_form'
    end

    def get_token
      render 'users/get_token_form'
    end

    def create_user
      api_call = create_alumni_user(params)
      logger.info(api_call.ai)
      @result = JSON.parse(api_call.to_s)
      @result["code"] = api_call.code
      @result["user"].delete("token")
      respond_to do |format|
        format.js {render layout: false}
      end
      #render 'users/user_result'
      #render inline: "<%= JSON.neat_generate(@result) %>"
    end


    def get_user_token
      api_call = get_user_token_call(params)
      system_env = params[:environment]
      if system_env != 'prod'
        domain_url = "#{system_env}-hub.k2practice.com"
      else
        domain_url = 'learn.k2p.com'
      end
      @result = JSON.parse(api_call.to_s)
      @result["code"] = api_call.code
      @result["url"] = domain_url
      logger.info(@result.ai)
      respond_to do |format|
        format.js {render layout: false}
      end
    end


    def create_alumni_user(data)
      url = Global.alumni.system_url + "/api/system/users"
      access_token = Global.alumni.access_token
      payload = { access_token: access_token, email: data['email'], first_name: data['first_name'], middle_name: data['middle_name'], last_name: data['last_name'], titles: data['degrees'] }
      logger.info("Sending to Alumni: #{url} for User Create: #{payload.ai}")
      response = RestClient::Request.new({
        method: :post,
        url: url,
        #user: 'someone',
        #password: 'mybirthday',
        payload: payload,
        headers: { :accept => :json, content_type: :json }
      }).execute do |response, request, result|
        response
      end

    end



    def get_user_token_call(data)
      alumni_env = data['environment']
      domain_url = "alumni.k2practice.com/api/system/users/token"
      if alumni_env == 'prod'
        url = 'https://' + domain_url
        access_token = Global.alumni.prod_access_token
      else
        url = 'https://' + alumni_env + '-' + domain_url
        access_token = Global.alumni.access_token
      end
      #url = Global.alumni.system_url + "/api/system/users/token"

      payload = { access_token: access_token, email: data['email'] }
      logger.info("Sending to Alumni: #{url} for Get User Token: #{payload.ai}")
      response = RestClient::Request.new({
           method: :get,
           url: url,
           #user: 'someone',
           #password: 'mybirthday',
           payload: payload,
           headers: { :accept => :json, content_type: :json }
       }).execute do |response, request, result|
          response
      end
    end


    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:course_session).permit(:course_id)
    end
  end

