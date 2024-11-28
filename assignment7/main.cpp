#include <mpi.h>
#include <random>
#include <functional>
#include <iostream>

class monteCarloIntegrator
{

private:
  // modern cpp prng instead of old srand()
  std::mt19937 gen;
  // uniform real distribution
  std::uniform_real_distribution<double> dist;
  // limits of integration
  double a,b;
  // number of sample points
  size_t nPoints;

public:

  monteCarloIntegrator
  (
    double lower_limit,
    double upper_limit, 
    size_t nPoints, 
    std::random_device & rd // pass by reference because no copy constrcutor for unique object
  ) :
  a(lower_limit),
  b(upper_limit),
  nPoints(nPoints),
  gen(rd())
  {
    // construct the uniform real distribution.
    dist = std::uniform_real_distribution<double>(a,b);
  }
  
  double integrate(const std::function<double(double)> &func) 
  {
    double sum = 0.0;
    // sample points and accumulate results
    for(int i=0;i<nPoints;i++)
    {
      double x = dist(gen);
      sum = sum + func(x);
    }
    return (b-a)*(sum/nPoints);
  }
  
    

};
int main (int argc, char *argv[]) {
   
  //- create source for prng, sources randomness from hardware
  std::random_device rd;
  double lower_bound = 0.0;
  double upper_bound = 1.0;
  size_t num_points = 1000000;

  // Create integrator instance
  monteCarloIntegrator integrator(lower_bound, upper_bound, num_points,rd);
  auto func = [](double x ){return x*x;};
  double result = integrator.integrate(func);
  double analytical = 1.0/3.0;  // Integral of x^2 from 0 to 1
  std::cout << "Monte Carlo estimate: " << result << std::endl;
  std::cout << "Analytical solution: " << analytical << std::endl;
  std::cout << "Absolute error: " << std::abs(result - analytical) << std::endl;


  return 0;
}
