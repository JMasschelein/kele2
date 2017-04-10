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

  private

  def base_url(endpoint, prod = true)
    if prod
      return "https://www.bloc.io/api/v1/#{endpoint}"
    else
      return "https://private-anon-bfb3dd2996-blocapi.apiary-mock.com/api/v1/#{endpoint}"
    end
	end
end