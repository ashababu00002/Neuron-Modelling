function [V,h,n,t] = HH0(I0,T0)
    dt = 0.01;
    T = ceil(T0/dt);
    
    C = 1;% capacitance density μF/cm^2
    gNa = 100;% current density μA/cm2
    gK = 80;% current density μA/cm2
    gL = 0.1; % current density μA/cm2
    VNa = 50; % mV
    VK = -100; % mV
    VL = -67; % mV
    % τ conductance density mS/cm2
    t =(1:T)*dt;
    V = zeros(T,1);
    h = zeros(T,1);
    n = zeros(T,1);
    % Initial conditions
    V(1) = -65; % mV
    h(1) = 0;
    n(1) = 0;
    for i=1:T-1
        V(i+1) = V(i) + dt * ((gNa * m_inf(V(i))^3 * h(i) * (VNa - V(i))) + (gK * n(i)^4 * (VK - V(i))) + (gL * (VL - V(i))) + I0) / C;
        h(i+1) = h(i) + dt * ((h_inf(V(i)) - h(i))/th(V(i)));
        n(i+1) = n(i) + dt * ((n_inf(V(i)) - n(i))/tn(V(i)));
    end
end

function m_inf = m_inf(V)
m_inf = (alpha_m(V))/(alpha_m(V)+beta_m(V));
end

function h_inf = h_inf(V)
h_inf = (alpha_h(V))/(alpha_h(V)+beta_h(V));
end

function n_inf = n_inf(V)
n_inf = (alpha_n(V))/(alpha_n(V)+beta_n(V));
end

function tH = th(V)
tH = 1/(alpha_h(V)+beta_h(V));
end

function tN = tn(V)
tN = 1/(alpha_n(V)+beta_n(V));
end

function aM = alpha_m(V)
    aM = 0.32 * (V + 54) / (1 - exp(-(V + 54) / 4));
end

function bM = beta_m(V)
    bM = 0.28 * (V + 27) / (exp((V + 27) / 5) - 1);
end

function aH = alpha_h(V)
    aH = 0.128 * exp(-(V + 50) / 18);
end

function bH = beta_h(V)
    bH = 4 / (1 + exp(-(V + 27) / 5));
end

function aN = alpha_n(V)
    aN = 0.032 * (V + 52) / (1 - exp(-(V + 52) / 5));
end

function bN = beta_n(V)
    bN = 0.5 * exp(-(V + 57) / 40);
end