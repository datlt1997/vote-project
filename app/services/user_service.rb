class UserService
  def initialize(current_user = nil)
    @current_user = current_user
    @repo = ::Repositories::UserRepository.new
  end

  def list_all
    @repo.all
  end

  def show(id)
    @repo.find(id)
  end

  def create(params)
    @repo.create(params)
  end

  def update(id, params)
    record = @repo.find(id)
    return nil unless record
    @repo.update(record, params)
    record
  end

  def destroy(id)
    record = @repo.find(id)
    return false unless record
    @repo.destroy(record)
  end
end
