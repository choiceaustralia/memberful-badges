
class MemberfulController < ApplicationController
  def status
    render json: { version: '0.3.0' }
  end

  def test
    render jsom: params
  end
end
