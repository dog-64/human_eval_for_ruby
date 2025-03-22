
def find_zero(xs)
    # Implementation of the bisection method to find a zero of a polynomial
    left = -10.0
    right = 10.0
    while (right - left) > 0.0001
        mid = (left + right) / 2.0
        if evaluate_polynomial(xs, mid) * evaluate_polynomial(xs, mid + 0.0001) < 0
            right = mid
        else
            left = mid
        end
    end
    return (left + right) / 2.0
end

def evaluate_polynomial(xs, x)
    # Evaluate a polynomial at a given point
    y = 0.0
    xs.each do |c|
        y += c * (x ** xs.length - 1)
    end
    return y
end