#include "NormalDistribution.h"

#define ARC4RANDOM_MAX 0x100000000

double drand_uniform(double low, double high)
{
    return low + (double)arc4random() * (high - low) / ARC4RANDOM_MAX;
}

int irand_uniform(int low, int high)
{
    return (int)floor(drand_uniform(low, high+1));
}

double drand_gauss(double mean, double sdev)
{
    double r, theta;
    // Make a positive number distributed as  r exp(-r*r/2)
    // by applying the inverse of the cumulative 1.0 - exp(-r*r/2) 
    // to a uniform number in range [0,1).
    r = sqrt( -2.0 * log (1.0 - drand_uniform(0,1)));
    // Make a number between -PI and PI
    theta = drand_uniform(-M_PI, M_PI);
    // Take the x coordinate and rescale
    return mean + sdev * r * sin(theta);
}

int getDiscreteGauss(double gauss, int min, int max)
{
    int discreteGauss = round(gauss);
    
    if (discreteGauss < min)
    {
        discreteGauss = min;
    }
    else if (discreteGauss > max)
    {
        discreteGauss = max;
    }
    
    return discreteGauss;
}
