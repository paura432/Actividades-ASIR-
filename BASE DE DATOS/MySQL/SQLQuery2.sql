SELECT nombre,mail,
datename(month,fecha) mes,
datename(day,fecha) dia,
datename(hour,fecha) hora 
FROM visitas
;