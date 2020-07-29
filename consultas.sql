/* 1. Cantidad de registros de la tabla de vuelos: Resultado: TOTAL 4758 */
SELECT COUNT(*)
FROM Flights;

/*2. Retraso promedio de salida y llegada según el aeropuerto origen.  */

SELECT Origin, AVG(ArrDelay), AVG(DepDelay)
FROM Flights
GROUP BY Origin;

/*3. Retraso promedio de llegada de vuelos, por meses, años y según aeropuerto de origen. Mostrar resultados DESC */

SELECT Origin, colYear, colMonth, AVG(ArrDelay)
FROM Flights
GROUP BY Origin, colYear, colMonth
ORDER BY Origin, colYear, colMonth;

/*4. Misma consulta que antes, pero mostrar ciudad en vez de código de aeropuerto   */

SELECT AIRP.City, FL.colYear, FL.colMonth, AVG(FL.ArrDelay)
FROM Flights as FL
LEFT JOIN USAirports as AIRP
ON FL.Origin = AIRP.IATA
GROUP BY City, colYear, colMonth
ORDER BY City, colYear, colMonth;

/*5. Las compañías con más vuelos cancelados, por meses y año. Además, deben estar ordenadas de forma que las compañías con más cancelaciones aparezcan las primeras.  */

SELECT UniqueCarrier, colYear, colMonth, SUM(Cancelled) as total_cancelados
FROM Flights
GROUP BY UniqueCarrier, colYear, colMonth
HAVING total_cancelados > 0
ORDER BY total_cancelados DESC, colYear ASC, colMonth ASC
o
SELECT UniqueCarrier, colYear, colMonth, SUM(Cancelled)
FROM Flights
INNER JOIN USAirports
ON Origin = IATA
GROUP BY UniqueCarrier, colYear, colMonth
HAVING SUM(Cancelled) > 0
ORDER BY SUM(Cancelled) DESC;

/* 6. El identificador de los 10 aviones que más distancia han recorrido haciendo vuelos. */

SELECT TailNum, SUM(Distance) as totalDistance
FROM Flights
WHERE TailNum != "NA" and TailNum != "#?NOMBRE?"
GROUP BY TailNum
ORDER BY totalDistance DESC
Limit 10;

/* 7. Compañías con su retraso promedio (mayor de 10 minutos) */


SELECT UniqueCarrier, avg(ArrDelay) as avgDelay
FROM Flights
GROUP BY UniqueCarrier
HAVING avgDelay > 10.0
ORDER BY avgDelay DESC;
