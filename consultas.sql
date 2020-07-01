/* 1. Cantidad de registros de la tabla de vuelos: Resultado: TOTAL 4758 */
SHOW DATABASES;
use USAirlineFlights2;
SELECT * 
FROM flights;
SELECT COUNT(*) FROM flights;

/*2. Retraso promedio de salida y llegada según el aeropuerto origen.  */

SELECT origin, AVG (deptime) AS promedio_salida, AVG (arrtime) AS promedio_llegada
FROM flights
GROUP BY origin;

/*3. Retraso promedio de llegada de vuelos, por meses, años y según aeropuerto de origen. Mostrar resultados DESC */

SELECT origin, colYear, colMonth, AVG (arrtime) AS promedio_llegada
FROM flights
ORDER BY origin ASC, colYear ASC, colMonth ASC;

/*4. Misma consulta que antes, pero mostrar ciudad en vez de código de aeropuerto   */

SELECT AIR.city, colYear, colMonth, AVG (ArrTime) AS promedio_llegada
FROM flights AS FL, usairports AS 
WHERE FL.Origin = usairports.iata  
GROUP BY AIR.City ASC, FL.colYear ASC, FL.col.Month ASC; 

/*5. Las compañías con más vuelos cancelados, por meses y año. Además, deben estar ordenadas de forma que las compañías con más cancelaciones aparezcan las primeras.  */

SELECT carriercode, colmonth, colyear, cancelled AS total_cancelados
FROM flights
GROUP BY carriercode
ORDER BY cancelled DESC, colyear ASC, colMonth ASC;

/* 6. El identificador de los 10 aviones que más distancia han recorrido haciendo vuelos. */

SELECT tailnum AS identificador_avion, SUM(distance) AS total_distance
FROM flights
WHERE tailnum IS NOT NULL
GROUP BY tailnum
LIMIT 10 OFFSET 1;

/* 7. Compañías con su retraso promedio (mayor de 10 minutos) */

SELECT carriercode , AVG(arrdelay) AS retraso_promedio
FROM flights
GROUP BY carriercode
HAVING arrdelay > 10
GROUP BY arrdelay DESC;
