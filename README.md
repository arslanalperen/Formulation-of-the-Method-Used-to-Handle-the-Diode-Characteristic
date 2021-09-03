# Formulation of the Method Used to Handle the Diode Characteristic
**<h1>Purpose</h1>**  

The voltage-versus-current characteristic of a practical diode at forward biased region (v_d>0) can be  approximated by the Shockley diode equation:

i_D  = I_S (e^(V_D/(nV_T))-1)     (1)

Where

	i_D is the current [A] through the diode,
	V_D is the diode voltage [V],
	I_S is the leakage (or reverse saturation) current, typically in the range of 10^(-6)  A to 10^(-5)  A ,
	 n  is the empirical constant known as the emission coefficient or the ideality factor, whose value varies from 1 to 2,
	V_T is a constant called the thermal voltage.


The diode current i_D will be very small if the diode voltage V_D is less than a specific value V_TD, known as the threshold voltage or the cut-in voltage or the turn-on voltage (typically 0.7 V). The diode conducts fully if V_D is higher than V_TD. Thus, the threshold voltage is the voltage at which a forward-biased diode begins to conduct fully. For V_D  > 0.1 V, which is usually the case, i_D  >> I_S, and Eq. (1) can be approximated by

i_D  = I_S (e^(V_D/nV_T )-1) ≅ I_S e^(V_D/(nV_T))      (2)

The voltage-versus-current characteristic of a diode at forward biased region (V_D  > 0) is measured at a junction temprature of 25 ⁰C and the measured values are plotted in Figure 1 and given in the data file (fprdata.dat), where the first column is the voltage in V and the second column is the measured current in A. This diode is used in the RL circuit shown in Figure 2, where the switch is closed at t = t_0. Formulate and write a code to calculate the current i(t), voltages v_1 (t), v_2 (t), and v_D (t) for V_S  = 2 V, L = 0.98 H,R = 14.2 Ω,t_0  = 0 s,and i_0  = 0 A for the time interval t ∈ [0,600] ms using the step sizes ∆t = 25 ms and ∆t = 2.5 ms. Assume that v_D (0) = 0 V for t = 0 s.

Followings should be included to your report:

	Formulation for the initial value problem
	Formulation of the method used to handle the diode characteristic.  

![a](/images/a.png)
![b](/images/b.png)  

Figure 1: The measured voltage-current characteristic of a diode at forward biased region: (a) linear, (b) logarithmic scales.  

![2](/images/2.png)  

	Plots of the current i(t), voltages v_1 (t),v_2 (t),and v_D (t) versus time t.
	Which methods are used?
	Include all necessary values and figures (depending on the used methods).
	Include your comments and if possible your analysis to your report in a separate section.  

**<h1>Preparatory Work</h1>**  

Approximating a dataset using a polynomial equation is useful when conducting engineering calculations as it allows results to be quickly updated when inputs change without the need for manual lookup of the dataset. The most common method to generate a polynomial equation from a given data set is the least squares method.

To fit a functional form

y = Ae^Bx      (3)

take the logarithm of both sides

ln V_d  = ln A + B x     (4)

The best-fit values are then

a =  (∑_(i=1)^n 〖(〖x^2〗_i y_i) ∑_(i=1)^n 〖(y_i  ln y_i) - ∑_(i=1)^n 〖(x_i y_i)∑_(i=1)^n 〖(x_i y_i  ln y_i)〗〗〗〗)/(∑_(i=1)^n y_i   ∑_(i=1)^n 〖(〖x_i〗^2 y_i)〗  - 〖(∑_(i=1)^n 〖x_i y_i 〗)〗^2 )
b =  (∑_(i=1)^n 〖(y_i) ∑_(i=1)^n 〖(x_i y_i  ln y_i) - ∑_(i=1)^n 〖(x_i y_i)∑_(i=1)^n 〖(y_i  ln y_i)〗〗〗〗)/(∑_(i=1)^n y_i   ∑_(i=1)^n 〖(〖x_i〗^2 y_i)〗  - 〖(∑_(i=1)^n 〖x_i y_i 〗)〗^2 )

where B ≡ b and A ≡ exp(a).

If equation (3) is compared with the diode current formula in equation (1):

y = i_D,A = I_S,x= V_D

A and B coefficients can be found when the data given by the least squares method are used together. As a result, the diode current equation is obtained. When the circuit in Figure 2 is examined, equation 5 can be obtained.

V_S  = V_1  + V_d  + V_2      (5)

Voltage formulas for resistance and inductance are already known.

V_1  = iR
V_2  = L di/dt

The resistance and inductance formulas can be substituted in equation 5.

V_S  = i(t)R + V_d  + L (di(t))/dt      (6)

The current of the circuit must be found according to time. Therefore, the derivative statement of the current should be left alone. As a result, equation (7) is obtained.

(di(t))/dt  =  V_S/L  -  (i(t)R)/L  -  e^((i(t))/A)/BL      (7)
To use the formula more easily, Vd can be written instead of the expansion. If the equation is rearranged by doing this, equation 8 is obtained.

(di(t))/dt  =  1/L(V_S  - i(t)R - V_d)     (8)

The first value of the current in a given time interval is given. Initial value problem solution methods can be used to find the current value in the next time according to the desired time step in the given time interval. The Runge-Kutta Method was preferred in the solution. The reason why this method is preferred is that it gives more realistic results than other methods.

In numerical analysis, the Runge-Kutta methods are a family of implicit and explicit iterative methods, which include the well-known routine called the Euler Method, used in temporal discretization for the approximate solutions of ordinary differential equations.

The most widely known member of the Runge-Kutta family is generally referred to as “RK4”, the “classic Runge-Kutta method” or simply as “the Runge-Kutta method”.

Let an initial value problem be specified as follows:

dy/dt  = f(t,y),y(t_0) = y_0

Here y is an unknown function (scalar or vector) of time t, which we would like to approximate; we are told that dy/dt, the rate at which y changes, is a function of t and of y itself. At the initial time t_0 the corresponding y value is y_0. The function f and the initial conditions t_0, y_0 are given.

Now pick a step-size h > 0 and define

y_(n+1)=y_n+1/6 h(k_1+2k_2+2k_3+k_4 ),
t_(n+1)  = t_n  + h

For n = 0,1,2,3 ...  using

k_1  = f(t_n,y_n),
k_2  = f(t_n+h/2  ,y_n+h k_1/2),
k_1  = f(t_n+h/2,y_n h k_2/2),
k_1  = f(t_n+h,y_n+hk_3),

Here y_(n+1) is the RK4 approximation of y(t_(n+1)), and the next value (y_(n+1)) is determined by the present value (y_n) plus the weighted average of four increments, where each increment is the product of the size of the interval, h, and an estimated slope specified by function f on the right-hand side of the differential equation.

	k_1 is the slope at the beginning of the interval, using y (Euler’s method);
	k_2 is the slope at the midpoint of the interval, using y and k_1;
	k_3 is again the slope at the midpoint, but now using y and k_2;
	k_4 is the slope at the end of the interval, using y and k_3;

In averaging the four slopes, greater weight is given to the slopes at the midpoint. If f is independent of y, so that the differential equation is equivalent to a simple integral, then RK4 is Simpson’s rule.

With the operations done so far, the current values of the circuit were obtained according to time. There are also voltage values among those requested. The resistor voltage can be found by equation 9, inductance voltage by equation 10, and diode voltage by equation 11.

V_1  = i(t)R     (9)
V_2  = L (di(t))/dt      (10)
V_d  =  (ln (i(t))/A)/LB      (11)

**<h1>Analysis</h1>**  

The problem will be solved in the order described in the preparation section. As a first step, the diode equation should be created. The coefficients of the equation will be calculated using the least squares method and the equation will be created.  

![3](/images/3.png)  

The variables belonging to the equations that will be used to calculate the coefficients are defined as seen in figure (3). The operations to be carried out later were made in the for loop as described in the preparatory work. The number of loop data has been returned and the series totals assigned to the relevant variables.  

![4](/images/4.png)  

Using the calculated variables, the coefficients a and b were calculated as seen in Figure (4)and they were ready to take their place in the formula with the  B ≡ b and A ≡ exp(a).  

![5](/images/5.png)  

The general graph of the obtained equation can also be done in the range of data given in Figure (5).
 

If the results of the operations are plotted with the plot command, figure (6) is obtained.  

![6](/images/6.png)  
![7](/images/7.png)  

The data obtained can also be shown as in figure (7).  

![8](/images/8.png)  

Now that the diode equation is obtained, Runge-Kutta can be applied (Figure 8). First, the constant values are defined. The Runge-Kutta method will be used first for a 25 ms time step. After the current and diode matrix are defined, the values given to their initial values are assigned. Then, using these values, Runge-Kutta method was applied as described in the preparatory work.  

![9](/images/9.png)  

The diode voltage was obtained as shown in figure (8). Resistance and inductance voltages are also obtained in Figure (9), as previously described in the preparatory work section.  
![10](/images/10.png)  

Figure (10) is obtained when the calculated data are plotted. With very little change in code, the same operations can be done for a 2.5 ms time step. Since the code is very similar to the code written for 25ms, their images will not be given.  

![11](/images/11.png)  

Figure (11) is obtained when the calculated data are plotted. In order to see the difference better, the graphs can be drawn together as in figure (12).  

![12](/images/12.png)
