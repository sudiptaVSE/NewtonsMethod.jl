using NewtonsMethod
using Test

@testset "NewtonsMethod.jl" begin
   testf(x)= (x-1)^3
    testf_prime(x)=3*(x-1)^2
    testf1(x)= exp(3*x)-1
    testf1_prime(x)=3*exp(3*x)
    
    #test for functions with derivative

    root1, conv, iter  = NewtonsMethod.newtonroot(testf,testf_prime; x_0 = 0.0)
    root2, conv, iter  = NewtonsMethod.newtonroot(testf1,testf1_prime; x_0 = 0.0)
    
    @test abs(root1 - 1.0)<1e-6
    @test abs(root2 - 0.0)<1e-6
    
    #do the same for functions without derivative

    root1, conv, iter  = NewtonsMethod.newtonroot(testf; x_0 = 0.0)
    root2, conv, iter  = NewtonsMethod.newtonroot(testf1; x_0 = 0.0)
    
    @test abs(root1 - 1.0) < 1e-6
    @test abs(root2 - 0.0) < 1e-6
    

    #Test if maxiter works
    root1, conv, iter  = NewtonsMethod.newtonroot(testf, testf_prime; x_0 = 0.0,  maxiter = 5)
    # if the function converged, return number of iteration, else return nothing 
    @test iter == nothing ||iter <= 5
    #Test different tolerance, increasing it to 1e-10
    root1, conv, iter  = NewtonsMethod.newtonroot(testf, testf_prime; x_0=0.0,  tol = 1e-10)
    @test abs(root1-1.0)<1e-7
    
    #Test lack of convergence
    
    test_nc(x) = x^2+1

    rootnc, conv, iter  = NewtonsMethod.newtonroot(test_nc; x_0 = 1.0)
    @test rootnc==nothing
   
    x0 = BigFloat(0.79)
    root1, conv, iter  = NewtonsMethod.newtonroot(testf; x_0 = x0)
    root2, conv, iter  = NewtonsMethod.newtonroot(testf1; x_0 = x0)
    
    @test abs(root1 - 1.0)<1e-6
    @test abs(root2 - 0.0)<1e-6
    
end
