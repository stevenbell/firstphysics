% gearbox_curves.m
% Motor curves used to analyze gearbox efficiencies

clc; clear; close all;

%%

% Data for CIM motor
freeSpeed = 5310; % RPM
freeCurrent = 2.7; % Amps
stallTorque = 2.43; % Newton-meters
stallCurrent = 133; % Amps


operatingVoltage = 12; % Volts

numPoints = 1000;

torque = linspace(0, stallTorque, numPoints);

% Speed and current are linear, so that's easy!
speed = linspace(freeSpeed, 0, numPoints);
current = linspace(freeCurrent, stallCurrent, numPoints);

% convert RPM to rad/sec
radSpeed = speed / 60 * 2 * pi;

% Assuming a 1m lever arm, the distance traveled in 1 second = speed in rad/sec
distanceTraveled = radSpeed;

% And the force is torque/1m
force = torque;

% w = F*x, P = w/t
powerOut = force .* distanceTraveled;

% Electrically, P = I * V
powerIn = current .* operatingVoltage;

efficiency = powerOut ./ powerIn * 100;
fprintf('efficiency w/o gearbox: %g', max(efficiency));

%%
gearboxRatio = 0.1; % 10:1 ratio
gearboxEfficiency = 0.9; % Nominal gearbox efficiency
gearboxLoad = stallTorque * (1 - sqrt(gearboxEfficiency)); % Newton-meters

freeSpeed_simple = freeSpeed * sqrt(gearboxEfficiency) * gearboxRatio
stallTorque_simple = stallTorque * sqrt(gearboxEfficiency) / gearboxRatio

freeSpeed = freeSpeed * (1 - (gearboxLoad/stallTorque)) * gearboxRatio
stallTorque = (stallTorque - gearboxLoad) / gearboxRatio

% Redo all of the calculations with the new numbers
torque = linspace(0, stallTorque, numPoints);

% Speed and current are linear, so that's easy!
speed = linspace(freeSpeed, 0, numPoints);
current = linspace(freeCurrent, stallCurrent, numPoints);

% convert RPM to rad/sec
radSpeed = speed / 60 * 2 * pi;

% Assuming a 1m lever arm, the distance traveled in 1 second = speed in rad/sec
distanceTraveled = radSpeed;

% And the force is torque/1m
force = torque;

% w = F*x, P = w/t
gpowerOut = force .* distanceTraveled;

% Electrically, P = I * V
powerIn = current .* operatingVoltage;

efficiency = gpowerOut ./ powerIn * 100;
fprintf('efficiency with gearbox: %g', max(efficiency));

%% Compare the results
figure;
plot(torque, powerOut, torque, gpowerOut)
relativePower = max(gpowerOut) / max(powerOut)
