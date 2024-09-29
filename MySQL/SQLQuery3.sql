SELECT mail,pais FROM visitas
where datename(month,fecha)='october'
order by 2
;