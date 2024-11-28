#ifndef MONTECARLO_H
#define MONTECARLO_H

#include <random>
class monteCarloIntegrator
{

private:
  // source randomness from hardware
  static std::random_device rd;
  // modern cpp prng instead of old srand()
  std::mt19937 gen;
  // uniform real distribution
  std::uniform_real_distribution<double> dist;
  // limits of integration
  double a,b;
  // number of sample points
  size_t nPoints;

public:
  monteCarloIntegrator(double lower_limit,double upper_limit, size_t nPoints) :
  a(lower_limit),
  b(upper_limit),
  nPoints(nPoints),
  gen(rd())
  {
    dist = std::uniform_real_distribution<double>(a,b);
  }
  
    

};



#endif // !MONTECARLO_H

