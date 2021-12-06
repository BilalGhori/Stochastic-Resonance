from scipy.integrate import solve_ivp, odeint
import numpy as np


def solve_cPRmodel_Ih(t_dur, g_c,g_h,Vi_half,E_h,Ih_flag, I_stim_s, I_stim_d, stim_start, stim_end):

    C_m = 3.     # membrane capacitance [uF cm**-2]
    p = 0.5      # proportion of the membrane area taken up by the soma

    g_L  = 0.1   # [mS cm**-2]
    g_Na = 30.   # [mS cm**-2]
    g_DR = 15.   # [mS cm**-2]
    g_Ca = 10.   # [mS cm**-2]
    g_KCa = 15.  # [mS cm**-2]
    g_KAHP = 0.8 # [mS cm**-2]
   

    E_L = -60.   # [mV]
    E_Na = 60.   # [mV]
    E_K = -75.   # [mV]
    E_KAHP = -75.# [mV]
    E_Ca = 80.   # [mV]
    E_KCa = -75. # [mV]
    
    
    

    def alpha_m(Vs):
        V1 = Vs + 46.9
        alpha = - 0.32 * V1 / (np.exp(-V1 / 4.) - 1.)
        return alpha

    def beta_m(Vs):
        V2 = Vs + 19.9
        beta = 0.28 * V2 / (np.exp(V2 / 5.) - 1.)
        return beta
    
    def alpha_n(Vs):
        V3 = Vs + 24.9
        alpha = - 0.016 * V3 / (np.exp(-V3 / 5.) - 1)
        return alpha

    def beta_n(Vs):
        V4 = 0.025*Vs + 1.
        beta = 0.25 * np.exp(-V4)
        return beta

    def alpha_h(Vs):
        alpha = 0.128 * np.exp((-43. - Vs) / 18.)
        return alpha

    def beta_h(Vs):
        V5 = Vs + 20.
        beta = 4. / (1 + np.exp(-V5 / 5.))
        return beta

    
    def alpha_s(Vd):
        alpha = 1.6 / (1 + np.exp(-0.072 * (Vd-5.)))
        return alpha

    def beta_s(Vd):
        V6 = Vd + 8.9
        beta = 0.02 * V6 / (np.exp(V6 / 5.) - 1.)
        return beta
        
    def m_inf(Vs):
        return alpha_m(Vs) / (alpha_m(Vs) + beta_m(Vs))
  
    def taum(Vs):
        return 1 / (alpha_m(Vs) + beta_m(Vs))
    
    def n_inf(Vs):
        return alpha_n(Vs) / (alpha_n(Vs) + beta_n(Vs))
    
    def taun(Vs):
        return 1 / (alpha_n(Vs) + beta_n(Vs))
    
    def h_inf(Vs):
        return alpha_h(Vs) / (alpha_h(Vs) + beta_h(Vs))
    
    def tauh(Vs):
        return 1 / (alpha_h(Vs) + beta_h(Vs))
    
    def s_inf(Vd):
        return alpha_s(Vd) / (alpha_s(Vd) + beta_s(Vd))
    
    def taus(Vd):
        return 1 / (alpha_s(Vd) + beta_s(Vd))
    
    def c_inf(Vd):
        return (1.0/(1.0 + np.exp((-10.1 - Vd)/0.1016)))**0.00925

    def tauc(Vd):
        return (3.627*np.exp(0.03704*Vd))

    def q_inf(Ca):
        return (0.7894*np.exp(0.0002726*Ca))-(0.7292*np.exp(-0.01672*Ca))

    def tauq(Ca):
        return (657.9*np.exp(-0.02023*Ca))+(301.8*np.exp(-0.002381*Ca))

    def Chi(Ca):
        return (1.073*np.sin(0.003453*Ca+0.08095) + 0.08408*np.sin(0.01634*Ca-2.34) +0.01811*np.sin(0.0348*Ca-0.9918))
    
    def a_i(Vd,Vi_half):
        return np.exp(-0.1054*(Vd-60-Vi_half))
    
    def b_i(Vd,Vi_half):
        return np.exp(0.1581*(Vd-60-Vi_half))
    
    def i_inf(Vd,Vi_half):
        return a_i(Vd,Vi_half) / (a_i(Vd,Vi_half) + b_i(Vd,Vi_half))
    
    def taui(Vd,Vi_half):
        return 500 / (a_i(Vd,Vi_half) + b_i(Vd,Vi_half)) 

   
    

    def dVdt(t, V):
       
        Vs, Vd, n, h, s, c, q, i, Ca = V

        I_leak_s = g_L*(Vs - E_L)
        I_leak_d = g_L*(Vd - E_L)
        I_Na = g_Na * m_inf(Vs)**2 * h * (Vs - E_Na)
        I_DR = g_DR * n * (Vs - E_K)
        I_ds = g_c * (Vd - Vs)
        
        I_Ca = g_Ca * s**2 * (Vd - E_Ca)
        I_KCa = g_KCa * c*Chi(Ca)* (Vd - E_KCa)
        I_KAHP = g_KAHP * q * (Vd - E_KAHP)
        I_h = g_h * i * (Vd - E_h)    
        I_sd = -I_ds 
        if t>stim_start and t<stim_end:
            dVsdt = (1./C_m)*( -I_leak_s - I_Na - I_DR + I_ds/p + I_stim_s/p )
        else:
            dVsdt = (1./C_m)*( -I_leak_s - I_Na - I_DR + I_ds/p)
            
        if Ih_flag==1:
            dVddt = (1./C_m)*( -I_leak_d - I_Ca - I_KCa - I_KAHP - I_h + I_sd/(1-p) + I_stim_d/(1-p))
        else:
            dVddt = (1./C_m)*( -I_leak_d - I_Ca - I_KCa - I_KAHP  + I_sd/(1-p) + I_stim_d/(1-p))
            
            
        dVddt = (1./C_m)*( -I_leak_d - I_Ca - I_KCa - I_KAHP - I_h + I_sd/(1-p) + I_stim_d/(1-p))
        dndt = (n_inf(Vs) - n)/taun(Vs)
        dhdt = (h_inf(Vs) - h)/tauh(Vs)
        dsdt = (s_inf(Vd) - s)/taus(Vd)
        dcdt = (c_inf(Vd) - c)/tauc(Vd)
        dqdt = (q_inf(Ca) - q)/tauq(Ca)
        didt = (i_inf(Vd,Vi_half) - i)/taui(Vd,Vi_half)
        dCadt = -0.13*I_Ca - 0.075*Ca

        return dVsdt, dVddt, dndt, dhdt, dsdt, dcdt, dqdt, didt, dCadt

    t_span = (0, t_dur)

    Vs0 = -64.74602
    Vd0 = -64.62836
    #n0 = 0.0004751724
    #h0 = 0.9987894
    #s0 = 0.00939306
    #c0 = 0.00698
    #q0 = 0.06293
    #i0 = 0.9999898
    Ca0 = 0.2211822
    
    n0=n_inf(Vs0)
    h0=h_inf(Vs0)
    s0=s_inf(Vd0)
    c0=c_inf(Vd0)
    q0=q_inf(Ca0)
    i0=i_inf(Vd0,Vi_half)
    Ca0=Chi(Ca0)
    
    
    V0 = [Vs0, Vd0, n0, h0, s0, c0, q0, i0, Ca0]

    sol = solve_ivp(dVdt, t_span, V0, max_step=0.05)

    return sol

