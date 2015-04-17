clear
// Creates a lookup table f(epsilon)|epsilon for the Fermi-Dirac-Statistics
// f(epsilon) = 1/(1+exp((epsilon-mu)/(k*T)). The formula has to be rearanged
// to avoid problems with subtracting near zero values
// f(epsilon) = exp((epsilon-mu)/(k*T))/((1+exp(epsilon(i)/(k*T))))

epsilon = linspace(-0.1,-2,20)
k = 8.6173324*10^(-5)
T = 300

for i=1:1:length(epsilon)
    lookuptable(i,2) = exp(epsilon(i)/(k*T))/(1+exp(epsilon(i)/(k*T)))
    lookuptable(i,1) = epsilon(1,i)
end

function bsp3()
    disp(lookuptable)
endfunction

bsp3()
