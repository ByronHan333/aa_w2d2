require "employee"

class Startup
  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    return true if @salaries.keys.include?(title)
    false
  end

  def >(startup)
    return true if self.funding > startup.funding
    false
  end

  def hire(employee_name, title)
    if !valid_title?(title)
      raise RuntimeError.new("runtime error")
    end
    @employees << Employee.new(employee_name, title)
  end

  def size
    @employees.length
  end

  def pay_employee(employee)
    sal = salaries[employee.title]
    if @funding > sal
      employee.pay(sal)
      @funding -= sal
    else
      raise RuntimeError.new("runtime error")
    end
  end

  def payday
    @employees.each{|e| pay_employee(e)}
  end

  def average_salary
    num_emp = @employees.length
    total_sal = @employees.map{|e| @salaries[e.title]}.sum
    1.0*total_sal/num_emp
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(startup)
    @funding += startup.funding
    startup.salaries.each do |k,v|
      @salaries[k] = v if !@salaries.include?(k)
    end
    @employees += startup.employees
    startup.close
  end
end
