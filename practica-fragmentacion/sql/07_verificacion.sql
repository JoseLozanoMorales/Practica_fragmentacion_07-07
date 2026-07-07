-- 1) COMPLETITUD: la vista global debe tener el mismo numero
-- de filas que la tabla centralizada de referencia.
SELECT COUNT(*) AS filas_globales FROM pedidos_global;
-- Se compara con el conteo original en el nodo central de referencia.

-- 2) RECONSTRUCCION: una consulta general contra la vista global
-- debe dar el mismo resultado que la misma consulta contra la BD central.
SELECT sede, SUM(monto) FROM pedidos_global GROUP BY sede;

-- 3) DISJUNCION horizontal: ningun pedido debe aparecer en dos nodos.
SELECT pedido_id, COUNT(*) AS veces
FROM pedidos_global
GROUP BY pedido_id
HAVING COUNT(*) > 1; -- debe devolver CERO filas.
