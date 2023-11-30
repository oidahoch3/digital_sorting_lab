a = sumNumbers(1, 100);
n = fib(1, 5);
[A, U] = circleStats(4);
m = maxNumber(n);
randNumber = randBetween(1, 10);
b = fac(5);
c = facU(5);
d = detMatrix(zeros(3,3));
e = isSym(zeros(3,3));
f = GGT(7, 13);
[g, h] = statsMatrix(zeros(3,3));
i = sqrtNewton(100, 0.1);


%% 1 summe von 100 zahlen
function result = sumNumbers(x, y)
    result = sum(x:y);
end


%% 2 fibonacci
function result = fib(x, y)
    result = fibonacci(x:y);
end


%% 3 kreis umfang und fläche
function [A, U] = circleStats(R)
    A = round(pi*R^2);
    U = round(pi*R*2);
end


%% 4 max zahl in einem vektor
function result = maxNumber(a)
    result = max(a);
end


%% 5 random number between thresholds
function result = randBetween(x, y)
    result = x + (y - x) * rand;
end


%% 6 Faktorial berechnen
function result = fac(n)
    result = factorial(n);
end

%% poephoofd lex homework
function result = facU(poep)
    result = 1;
    for drol = 2:poep
        result = result * drol;
    end
end


%% 7 Matrix Determinante berechnen
function result = detMatrix(matrix)
    result = det(matrix);
end


%% 8 symmetrische Matrix
function result = isSym(matrix)
    result = issymmetric(matrix);
end


%% 9 größter gemeinsamer Teiler zweier Zahlen
function result = GGT(x, y)
    result = gcd(x, y);
end


%% 10 Durchschnitt und Standardabweichung einer Matrix
function [meanMatrix, stdDev] = statsMatrix(matrix)
    meanMatrix = mean(matrix);
    stdDev = std(matrix);
end

%% 11 plot für y = sin(x) von 0 bis 2π
function plotSines
    x = 0:pi/8:pi*2;
    plot(x, sin(x));
end


%% 12 Implementieren Sie den binären Suchalgorithmus, um das Vorkommen einer
%Zahl in einem sortierten Array zu finden.
%ich hab ein unsortiertes array zb 1,3,4,5,9,2. Ich will wissen wo meine 2
%is. Das array wird sortiert 123459 und teilt es in zwei hälften 123 / 459.
%Dann werden sich beide hälften angschaut: größer oder kleiner als 2? Und
%mit jedem Druchlauf wird das array halbiert.



%% 13 Quadratwurzel mit Newton Verfahren
function result = sqrtNewton(x, tolerance)
    result = x;

    %tolerance check
    while abs(result^2 - x) > tolerance

        % Newton equation
        result = 0.5*(result + (x/result));
    end
end




