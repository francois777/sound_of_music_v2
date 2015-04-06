class Admin::BaseController < ApplicationController
  before_action :allowed_to_approve!


end