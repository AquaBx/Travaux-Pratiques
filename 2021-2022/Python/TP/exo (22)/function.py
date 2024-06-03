#--------------------------------------------- 22 ---------------------------------------------
def code_grey(n):
    g1 = [[0],[1]]
    for i in range(1,n):
        l1 = [item + [0] for item in g1]
        l2 = [item + [1] for item in g1]
        l2.reverse()
        g1 = l1+l2
    return g1