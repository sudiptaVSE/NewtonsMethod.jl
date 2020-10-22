using NewtonsMethod
using Test

@testset "NewtonsMethod.jl" begin
   testf(x) = (x-1)^4
    testf_prime(x) = 4*(x-1)^3
    testf1(x) = exp(3*x)-1
    testf1_prime(x) = 3*exp(3*x)
    
    #test for functions with derivative

    root1, conv, iter  = NewtonsMethod.newtonroot(testf, testf_prime, 0.0)
    root2, conv, iter  = NewtonsMethod.newtonroot(testf1, testf1_prime, 1.0)
    
    @test abs(root1 - 1.0)<1e-6
    @test abs(root2 - 0.0)<1e-6
    
    #do the same for functions without derivative

    root1, conv, iter  = NewtonsMethod.newtonroot(testf, 0.0)
    root2, conv, iter  = NewtonsMethod.newtonroot(testf1, 1.0)
    
    @test abs(root1 - 1.0)<1e-6
    @test abs(root2 - 0.0)<1e-6
    

    #check maxiter works
    root1, conv, iter  = NewtonsMethod.newtonroot(testf, testf_prime, 0.5,  maxiter = 3)
    # if the function converged, return number of iteration, else return nothing 
    @test iter == nothing || iter <= 3
    #check for tolerance, increasing it to 1e-8
    root1, conv, iter  = NewtonsMethod.newtonroot(testf, testf_prime, x_0=0.5,  tol = 1e-8)
    @test abs(root1-1.0)<1e-7
    
    # Test no convergence
    
    test_nc(x) = x^2+1

    root_nc, conv, iter  = NewtonsMethod.newtonroot(test_nc,x_0=1.0)
    @test root_nc==nothing

    #check for the polynomials roots
    
    p_1 = Polynomial([2, -5, 2])
    p_2 = Polynomial(rand(4))
    
    root1, conv, iter  = NewtonsMethod.newtonroot(p_1,x_0=1.0)
    root2, conv, iter  = NewtonsMethod.newtonroot(p_2,x_0=1.0)
    
    @test minimum(abs.(roots(p_1).-root1))<=1e-6
    @test minimum(abs.(roots(p_2).-root2))<=1e-6
    



end
