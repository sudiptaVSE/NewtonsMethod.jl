using NewtonsMethod
using Test, Polynomials

@testset "NewtonsMethod.jl" begin
    testf(x) = (x-1)^2
    testf_prime(x) = 2*(x-1)
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
    #root1, conv, iter  = NewtonsMethod.newtonroot(testf, testf_prime, 0.5,  maxiter = 5)
    # if the function converged, return number of iteration, else return nothing 
   # @test iter == nothing || iter <= 5
    #check for tolerance, increasing it to 1e-8
    #root1, conv, iter  = NewtonsMethod.newtonroot(testf, testf_prime, x_0=0.5,  tol = 1e-8)
    #@test abs(root1-1.0)<1e-7
    
    # Test no convergence
    
    test_nc(x) = x^2+1

    root_nc, conv, iter  = NewtonsMethod.newtonroot(test_nc, 1.0)
    @test root_nc==nothing

   end
