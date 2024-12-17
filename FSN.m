function [V_f,h_f,n_f,t_f] = FSN(I0, T0)
    dt = 0.01;
    T = ceil(T0/dt);
    
    C_f = 1;% capacitance density μF/cm^2
    gNa_f = 35;% current density μA/cm2
    gK_f = 9;% current density μA/cm2
    gL_f = 0.1; % current density μA/cm2
    VNa_f = 55; % mV
    VK_f = -90; % mV
    VL_f = -65; % mV
    % τ conductance density mS/cm2
    t_f =(1:T)*dt;
    V_f = zeros(T,1);
    h_f = zeros(T,1);
    n_f = zeros(T,1);
    % Initial conditions
    V_f(1) = -65; % mV
    h_f(1) = 0;
    n_f(1) = 0;
    for i=1:T-1
        V_f(i+1) = V_f(i) + dt * ((gNa_f * (m_inf(V_f(i)))^3 * h_f(i) * (VNa_f - V_f(i))) + (gK_f * (n_f(i))^4 * (VK_f - V_f(i))) + (gL_f * (VL_f - V_f(i))) + I0) / C_f;
        h_f(i+1) = h_f(i) + dt * ((h_inf(V_f(i)) - h_f(i))/th(V_f(i)));
        n_f(i+1) = n_f(i) + dt * ((n_inf(V_f(i)) - n_f(i))/tn(V_f(i)));
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
tH = 0.2/(alpha_h(V)+beta_h(V));
end

function tN = tn(V)
tN = 0.2/(alpha_n(V)+beta_n(V));
end

function aM = alpha_m(V)
    aM = 0.1 * (V + 35) / (1 - exp(-(V + 35) / 10));
end

function bM = beta_m(V)
    bM = 4*exp(-(V + 60) / 18);
end

function aH = alpha_h(V)
    aH = 0.07 * exp(-(V + 58) / 20);
end

function bH = beta_h(V)
    bH = 1 / (exp(-0.1*(V + 28)) + 1);
end

function aN = alpha_n(V)
    aN = 0.01 * (V + 34) / (1 - exp(-0.1*(V + 34)));
end

function bN = beta_n(V)
    bN = 0.125 * exp(-(V + 44) / 80);
end
