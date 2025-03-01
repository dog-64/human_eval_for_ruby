def assert(condition, message = "Assertion failed")
  raise message unless condition
end

def assert_valid_order(result, dependencies)
  dependencies.each do |pred, succ|
    pred_index = result.index(pred)
    succ_index = result.index(succ)
    raise "Неверный порядок сортировки" unless pred_index < succ_index
  end
end

def assert_raises(exception_class)
  begin
    yield
    raise "Ожидалось исключение #{exception_class}, но оно не было вызвано"
  rescue exception_class
    true
  rescue StandardError => e
    raise "Ожидалось исключение #{exception_class}, но было получено #{e.class}: #{e.message}"
  end
end 
