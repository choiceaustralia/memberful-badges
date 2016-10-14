
class MemberfulController < ApplicationController
  protect_from_forgery unless: -> { true } # TODO

  def status
    render json: { version: '0.3.0' }
  end

  def test
    render json: params
  end
end
