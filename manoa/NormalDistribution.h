#ifndef manoa_NormalDistribution_h
#define manoa_NormalDistribution_h

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// --- uniform double in [low,high)
double drand_uniform(double low, double high);

// --- uniform integer in [low,high]
int irand_uniform(int low, int high);

// --- gaussian number with specified mean and sdev
double drand_gauss(double mean, double sdev);

int getDiscreteGauss(double gauss, int min, int max);

#endif
