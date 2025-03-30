require_relative 'logger'

# Модуль LogLevels был объединен с Logger
# Используйте модуль Logger вместо LogLevels
# @deprecated Пожалуйста, используйте Logger
module LogLevels
  def self.included(base)
    warn "[DEPRECATION] '#{self}' устарел. Используйте 'Logger' вместо него."
    base.include(Logger)
  end
end 