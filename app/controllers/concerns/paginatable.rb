# Paginatable module provides a paginate(scope) method which accepts a relation object and returns
# both the paginated relation and the total count
# Example:
#   @scope, @tota = paginate(@scope)
module Paginatable
  extend ActiveSupport::Concern

  DEFAULT_PER_PAGE = 10

  private

  def paginate(scope)
    @page =     params[:page]&.to_i     || 1
    @per_page = params[:per_page]&.to_i || DEFAULT_PER_PAGE

    [
      scope.offset((@page - 1) * @per_page).limit(@per_page),
      scope.count
    ]
  end
end
