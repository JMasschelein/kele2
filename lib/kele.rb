require 'httparty'
require 'json'

class Kele
  include HTTParty

  base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    options = {
      body: {
        email: "email",
        password: "password"
      }
    }

    response = self.class.post(base_url('sessions'), options)
    raise "Invalid Email or Password" if response.code != 200
    @auth_token = response["auth_token"]
  end
  
  def get_me
    headers = {
      headers: {
        :content_type => 'application/json',
        :authorization => @auth_token
      }
    }
    response = self.class.get(base_url('users/me'), headers)
    return @user_data = JSON.parse(response.body)
  end
  
    def get_mentor_availability(id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{id}/student_availability")
  end

  private

  def base_url(endpoint, prod = true)
    if prod
      return "https://www.bloc.io/api/v1/#{endpoint}"
    else
      return "https://private-anon-bfb3dd2996-blocapi.apiary-mock.com/api/v1/#{endpoint}"
    end
	end
end