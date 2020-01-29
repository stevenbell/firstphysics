% motorcurve.m
% Draws a motor curve sheet

% Data for CIM motor
% freeSpeed = 5310; % RPM
% freeCurrent = 2.7; % Amps
% stallTorque = 2.43; % Newton-meters
% stallCurrent = 133; % Amps

% Fisher-Price -9015
freeSpeed = 15600; % RPM
freeCurrent = 1; % Amps
stallTorque = .45; % Newton-meters
stallCurrent = 70; % Amps

% Data for BaneBots RS550
% freeSpeed = 19300;
% freeCurrent = 1.4;
% stallTorque = 0.486;
% stallCurrent = 85;

% Nippon-Denso
% freeSpeed = 84; % RPM
% freeCurrent = 1.8; % Amps
% stallTorque = 10.6; % Newton-meters
% stallCurrent = 18.6; % Amps


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

ploty4(torque, speed, torque, current, torque, powerOut, torque, efficiency);

grid on;
xlabel('Load (N\cdot m)');
legend('speed', 'current', 'power', 'effeciency');


maxPower = max(powerOut)
maxEfficiency = max(efficiency)

%%
[ax, p1, p2] = plotyy(torque, speed/1000, torque, current);
set(get(ax(1), 'YLabel'), 'String', 'Speed (rpm \times 1000)');
set(get(ax(2), 'YLabel'), 'String', 'Current (A)');
xlabel('Torque (N-m)');
title('Speed and Current vs Torque for Fisher-Price motor');
set(ax(1), 'XLim', [0, stallTorque]);
set(ax(2), 'XLim', [0, stallTorque]);
grid on;