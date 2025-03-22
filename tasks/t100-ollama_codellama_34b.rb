
def make_a_pile(n)
    piles = []
    current_level = n
    while current_level > 0
        if current_level % 2 == 1
            piles << current_level
        else
            piles << current_level - 1
        end
        current_level -= 1
    end
    return piles
end