module NewtonsMethod

using LinearAlgebra, ForwardDiff


function newtonroot(f::Function, f_prime::Function; x_0::Real, tol = 1E-7, maxiter = 1000)
    x_old=x_0
    normdiff=Inf
    iter=1
    
    if(abs(f_prime(x_old))<=tol)
        return (value=x_old,normdiff=f(x_old),iter=0)
    end 

    while normdiff>tol && iter<=maxiter
        x_new= x_old - f(x_old)/f_prime(x_old)
        if isnan(x_new)
            return (nothing, nothing, nothing)
        end
        normdiff=norm(x_new-x_old)
        x_old=x_new
        iter = iter + 1 
        
    end
    if(normdiff>tol)
        return (nothing, nothing, nothing)
    end

    return (value=x_old,normdiff=normdiff,iter=iter)
end
    

function newtonroot(f::Function; x_0::Real, tol = 1E-7, maxiter = 1000)
    #find derivate of f
    
    x_old=x_0
    normdiff=Inf
    iter=1

    D(f) = x -> ForwardDiff.derivative(f, x)
    f_prime=D(f)

    if(abs(f_prime(x_old))<=tol)
        return (value=x_old,normdiff=f(x_old),iter=0)
    end

    while normdiff>tol && iter<=maxiter
        x_new= x_old - f(x_old)/f_prime(x_old)
        if isnan(x_new)
            return (nothing, nothing, nothing)
        end
        normdiff=norm(x_new-x_old)
        x_old=x_new
        
        iter += 1 
    end
    if(normdiff>tol)
        return (nothing, nothing, nothing)
    end
    return (value=x_old,normdiff=normdiff,iter=iter)
end



end
