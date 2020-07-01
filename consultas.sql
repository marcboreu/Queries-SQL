/* 1. Cantidad de registros de la tabla de vuelos: Resultado: TOTAL 4758 */
SHOW DATABASES;
use USAirlineFlights2;
SELECT * 
FROM flights;
SELECT COUNT(*) FROM flights;

/*2. Retraso promedio de salida y llegada según el aeropuerto origen.  */

SELECT origin,
AVG (deptime) AS promedio_salida,
AVG (arrtime) AS promedio_llegada
FROM flights
GROUP BY origin;

/*3. Retraso promedio de llegada de vuelos, por meses, años y según aeropuerto de origen. Mostrar resultados DESC */

SELECT origin, colMonth, colYear, 
AVG (arrtime) AS promedio_llegada
FROM flights
GROUP BY origin ASC;

/*4. Misma consulta que antes, pero mostrar ciudad en vez de código de aeropuerto   */

SELECT * 
FROM usairports;
SELECT DISTINCT city, ColMonth, ColYear,
AVG (ArrTime) AS promedio_llegada
FROM flights
JOIN usairports
ON  flights.flightid = usairports.iata  
GROUP BY city ASC; 

/*5. 5. Las compañías con más vuelos cancelados, por meses y año. Además, deben estar ordenadas de forma que las compañías con más cancelaciones aparezcan las primeras.  */

SELECT * 
FROM flights;
SELECT * 
FROM carriers;
SELECT carriercode, colmonth, colyear, cancelled AS total_cancelados
FROM flights
JOIN carriers
ON flights.flightId = carriers.carriercode
GROUP BY description
ORDER BY cancelled DESC;

/* 6. El identificador de los 10 aviones que más distancia han recorrido haciendo vuelos. */

SELECT tailnum AS identificador_avion, SUM(distance) AS total_distance
FROM flights
WHERE tailnum IS NOT NULL
GROUP BY tailnum
LIMIT 10 OFFSET 1;

/* 7. Compañías con su retraso promedio (mayor de 10 minutos) */

SELECT * 
FROM flights;
SELECT carriercode, description, AVG(arrdelay) AS retraso_promedio
FROM flights
JOIN carriers
ON flights.flightId = carriers.carriercode
WHERE arrdelay > 10
GROUP BY arrdelay DESC;