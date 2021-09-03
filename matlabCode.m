clc; clear all;format long;

load ('fprdata.dat')
%%
%%Finding Voltage-Current Relation with Linear Least Squares Method

%Defining Sums
Sxi2yi = 0;
Syilnyi = 0;
Sxiyi = 0;
Sxiyilnyi = 0;
Syi = 0;
Sxiyi2 = 0;

%Calculating Sums
for i=1:1:5
    Sxi2yi = Sxi2yi + ((fprdata(i:i,1)^2)*fprdata(i:i,2));
    Syilnyi = Syilnyi + (fprdata(i:i,2)*log(fprdata(i:i,2)));
    Sxiyi = Sxiyi + (fprdata(i:i,1)*fprdata(i:i,2));
    Sxiyilnyi = Sxiyilnyi + (fprdata(i:i,1)*fprdata(i:i,2)*log(fprdata(i:i,2)));
    Syi = Syi + (fprdata(i:i,2));
end

%calculating the coefficients
a = ((Sxi2yi*Syilnyi)-(Sxiyi*Sxiyilnyi))/((Syi*Sxi2yi)-((Sxiyi)^2));
b = ((Syi*Sxiyilnyi)-(Sxiyi*Syilnyi))/((Syi*Sxi2yi)-(Sxiyi^2));
A = exp(a);
B = b;

for i=1:1:5
    current(i:i,1) = A*exp(B*fprdata(i:i,1)); 
end

%Calculating the current values of General Exponential Function
VdExtended = 0:0.01:fprdata(5,1)+0.01;
currentExtended = A*exp(B*VdExtended); 

%plotting graphs
figure(1);
subplot(2,2,1);
plot(fprdata(:,1),current(:,1),"r-");
xlabel("Voltage[V]");
ylabel("Current[A]");
title("Exponential Function");
subplot(2,2,2);
plot(fprdata(:,1),fprdata(:,2),"bx");
xlabel("Voltage[V]");
ylabel("Current[A]");
title("Given Values");
subplot(2,2,3);
plot(VdExtended,currentExtended,"g-");
xlabel("Voltage[V]");
ylabel("Current[A]");
title("Exponential Function's General Graph");
subplot(2,2,4);
plot(fprdata(:,1),current(:,1),"r-")
hold on
plot(fprdata(:,1),fprdata(:,2),"bx");
hold on
plot(VdExtended,currentExtended,"g-");
xlabel("Voltage[V]");
ylabel("Current[A]");
title("All Graphs");
sgtitle("Voltage-Current Relation of Diode");
figure(2);
subplot(1,2,1);
plot(fprdata(:,1),current(:,1),"b-");
title("Exponential Function");
xlabel("Voltage[V]");
ylabel("Current[A]");
subplot(1,2,2);
loglog(fprdata(:,1),current(:,1),"r-");
title("Exponential Function's Logarithmic Graph");
xlabel("Voltage[V]");
ylabel("Current[A]");
sgtitle("Voltage-Current Relation of Diode");
%%
%%Calculating the ODE for 25 ms

%Constant Values
Vs = 2;
L = 0.98;
R = 14.2;

%Variable Values
dt = 0.025;
I(1,1) = 0;
Vdiode(1,1) = 0;
t = 0:0.025:0.6;

%applying runge-kutta
for i=2:1:25
    di = (Vs/L)-((I(i-1:i-1,1)*R)/L)-(Vdiode(i-1:i-1,1)/L);
    K1 = dt*di;
    di = (Vs/L)-(((I(i-1:i-1,1)+(K1/2))*R)/L)-((Vdiode(i-1:i-1,1)+(K1/2))/L);
    K2 = dt*di;
    di = (Vs/L)-(((I(i-1:i-1,1)+(K2/2))*R)/L)-((Vdiode(i-1:i-1,1)+(K2/2))/L);
    K3 = dt*di;
    di = (Vs/L)-(((I(i-1:i-1,1)+K3)*R)/L)-((Vdiode(i-1:i-1,1)+K3)/L);
    K4 = dt*di;
    I(i:i,1) = I(i-1:i-1,1) + K1/6 + K2/3 + K3/3 + K4/6;
    %calculating the diode voltage
    Vdiode(i:i,1) = log(I(i:i,1)/A)/(L*B);
end

%Calculating the Inductor Voltage
for i=1:1:25
   di = (Vs/L)-((I(i:i,1)*R)/L)-(Vdiode(i:i,1)/L);
   Vinductor(i:i,1) = L*di; 
end

%Calculating the Resistor Voltage
for i=1:1:25
   Vresistor(i:i,1) = R*I(i:i,1); 
end

%plotting graphs
figure(3);
subplot(2,2,1);
plot(t,I(:,1));
xlabel("Time[s]");
ylabel("Current[A]");
title("Time-Current Relation");
subplot(2,2,2);
plot(t,Vdiode(:,1));
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Diode Voltage Relation");
subplot(2,2,3);
plot(t,Vinductor(:,1));
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Inductor Voltage Relation");
subplot(2,2,4);
plot(t,Vresistor(:,1));
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Resistor Voltage Relation");
sgtitle("Graphs for 25 ms Time Step");

%%
%%Calculating the ODE for 2.5 ms

%Constant Values
Vs = 2;
L = 0.98;
R = 14.2;

%Variable Values
dt = 0.0025;
I2(1,1) = 0;
Vdiode2(1,1) = 0;
t2 = 0:0.0025:0.6;

%applying runge-kutta
for i=2:1:241
    di = (Vs/L)-((I2(i-1:i-1,1)*R)/L)-(Vdiode2(i-1:i-1,1)/L);
    K1 = dt*di;
    di = (Vs/L)-(((I2(i-1:i-1,1)+(K1/2))*R)/L)-((Vdiode2(i-1:i-1,1)+(K1/2))/L);
    K2 = dt*di;
    di = (Vs/L)-(((I2(i-1:i-1,1)+(K2/2))*R)/L)-((Vdiode2(i-1:i-1,1)+(K2/2))/L);
    K3 = dt*di;
    di = (Vs/L)-(((I2(i-1:i-1,1)+K3)*R)/L)-((Vdiode2(i-1:i-1,1)+K3)/L);
    K4 = dt*di;
    I2(i:i,1) = I2(i-1:i-1,1) + K1/6 + K2/3 + K3/3 + K4/6;
    %calculating the diode voltage
    Vdiode2(i:i,1) = log(I2(i:i,1)/A)/(L*B);
end

%Calculating the Inductor Voltage
for i=1:1:241
   di = (Vs/L)-((I2(i:i,1)*R)/L)-(Vdiode2(i:i,1)/L);
   Vinductor2(i:i,1) = L*di; 
end

%Calculating the Resistor Voltage
for i=1:1:241
   Vresistor2(i:i,1) = R*I2(i:i,1); 
end

%plotting graphs
figure(4);
subplot(2,2,1);
plot(t2,I2(:,1));
xlabel("Time[s]");
ylabel("Current[A]");
title("Time-Current Relation");
subplot(2,2,2);
plot(t2,Vdiode2(:,1));
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Diode Voltage Relation");
subplot(2,2,3);
plot(t2,Vinductor2(:,1));
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Inductor Voltage Relation");
subplot(2,2,4);
plot(t2,Vresistor2(:,1));
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Resistor Voltage Relation");
sgtitle("Graphs for 2.5 ms Time Step");
%%
%different time step's graphs together
figure(5);
subplot(2,2,1);
plot(t,I(:,1),"r-");
hold on
plot(t2,I2(:,1),"b-");
xlabel("Time[s]");
ylabel("Current[A]");
title("Time-Current Relation");
legend("25 ms Time Step","2.5 ms Time Step");
subplot(2,2,2);
plot(t,Vdiode(:,1),"r-");
hold on
plot(t2,Vdiode2(:,1),"b-");
legend("25 ms Time Step","2.5 ms Time Step");
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Diode Voltage Relation");
subplot(2,2,3);
plot(t,Vinductor(:,1),"r-");
hold on
plot(t2,Vinductor2(:,1),"b-");
legend("25 ms Time Step","2.5 ms Time Step");
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Inductor Voltage Relation");
subplot(2,2,4);
plot(t,Vresistor(:,1),"b-");
hold on
plot(t2,Vresistor2(:,1),"r-");
legend("25 ms Time Step","2.5 ms Time Step");
xlabel("Time[s]");
ylabel("Voltage[V]");
title("Time-Resistor Voltage Relation");
sgtitle("All Time Step Graphs Together");