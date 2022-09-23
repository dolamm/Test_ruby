require 'net/http'
require 'uri'
require 'json'

class AuthController < ApplicationController
  def index
    if session[:user_id]
      redirect_to action: 'home'
    end
  end

  def signup
    email = params[:email]
    password = params[:password]

    uri = URI('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCH0xY9Ky5RRcDvg42s6AbtOfQvraeZh7Y')

    res = Net::HTTP.post_form(uri, 'email' => email, 'password' => password)

    data = JSON.parse(res.body)

    if res.is_a?(Net::HTTPSuccess)
      redirect_to action: 'index'
    end
  end

  def home
  end

  def login
    email = params[:email]
    password = params[:password]

    uri = URI('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCH0xY9Ky5RRcDvg42s6AbtOfQvraeZh7Y')

    res = Net::HTTP.post_form(uri, 'email' => email, 'password' => password)

    data = JSON.parse(res.body)

    if res.is_a?(Net::HTTPSuccess)

      session[:user_id] = data['localId']
      redirect_to action: 'home'
    end
  end

  def logout
    session.clear
    redirect_to action: 'index'
  end

end
