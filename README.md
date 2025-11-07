# Sistema de Gestión de Pedidos y Menús — Base de Datos

**Este proyecto define el modelo de base de datos para la gestión de pedidos, productos, menús, adiciones y clientes de una pizzería.
El diseño sigue un enfoque relacional simplificado (sin tablas de muchos a muchos), conservando únicamente las relaciones uno a muchos esenciales. 

Estas son las consultas principales que permiten la ventas y pedidos de la pizzería.**

- 1. Productos más vendidos (pizza, panzarottis, bebidas, etc.)
SELECT tipo, nombre, SUM(cantidad) AS total_vendidos
FROM pedido_producto
JOIN productos USING (id_producto)
GROUP BY tipo, nombre
ORDER BY total_vendidos DESC;

- 2. Total de ingresos generados por cada combo
SELECT c.nombre, SUM(c.precio) AS ingresos_totales
FROM combo c
JOIN pedidos p ON p.id_combo = c.id_combo
GROUP BY c.nombre;

- 3. Pedidos realizados para recoger vs. comer en la pizzería
SELECT tipo_pedido, COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY tipo_pedido;

- 4. Adiciones más solicitadas en pedidos personalizados
SELECT a.nombre, COUNT(*) AS total_solicitudes
FROM pedido_adicion pa
JOIN adiciones a ON pa.id_adicion = a.id_adiciones
GROUP BY a.nombre
ORDER BY total_solicitudes DESC;

- 5. Cantidad total de productos vendidos por categoría
SELECT tipo, SUM(cantidad) AS total_vendidos
FROM pedido_producto
JOIN productos USING (id_producto)
GROUP BY tipo;

- 6. Promedio de pizzas pedidas por cliente
SELECT c.nombre, AVG(pp.cantidad) AS promedio_pizzas
FROM pedido_producto pp
JOIN pedidos p ON p.id_pedido = pp.id_pedido
JOIN clientes c ON c.id_cliente = p.id_clientes
JOIN productos pr ON pr.id_producto = pp.id_producto
WHERE pr.tipo = 'Pizza'
GROUP BY c.nombre;

- 7. Total de ventas por día de la semana
SELECT DAYNAME(FROM_UNIXTIME(fecha)) AS dia, SUM(total) AS ventas
FROM pedidos
GROUP BY dia;

- 8. Cantidad de panzarottis vendidos con extra queso
SELECT SUM(pp.cantidad) AS total
FROM pedido_producto pp
JOIN productos pr ON pr.id_producto = pp.id_producto
JOIN pedido_adicion pa ON pa.id_pedido = pp.id_pedido
JOIN adiciones a ON a.id_adiciones = pa.id_adicion
WHERE pr.nombre LIKE '%Panzarotti%' AND a.nombre LIKE '%queso%';

- 9. Pedidos que incluyen bebidas como parte de un combo
SELECT DISTINCT p.id_pedido
FROM pedidos p
JOIN pedido_producto pp ON p.id_pedido = pp.id_pedido
JOIN productos pr ON pr.id_producto = pp.id_producto
WHERE pr.tipo = 'Bebida' AND p.id_combo IS NOT NULL;

- 10. Clientes que han realizado más de 5 pedidos en el último mes
SELECT c.nombre, c.apellido, COUNT(p.id_pedido) AS total_pedidos
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_clientes
WHERE MONTH(FROM_UNIXTIME(p.fecha)) = MONTH(CURRENT_DATE())
GROUP BY c.id_cliente
HAVING total_pedidos > 5;

- 11. Ingresos totales generados por productos no elaborados
SELECT SUM(pp.precio * pp.cantidad) AS total_no_elaborados
FROM pedido_producto pp
JOIN productos pr ON pr.id_producto = pp.id_producto
WHERE pr.tipo IN ('Bebida', 'Postre');

- 12. Promedio de adiciones por pedido
SELECT AVG(num_adiciones) AS promedio
FROM (
  SELECT COUNT(*) AS num_adiciones
  FROM pedido_adicion
  GROUP BY id_pedido
) AS sub;

- 13. Total de combos vendidos en el último mes
SELECT COUNT(*) AS total_combos
FROM pedidos
WHERE id_combo IS NOT NULL
  AND MONTH(FROM_UNIXTIME(fecha)) = MONTH(CURRENT_DATE());

- 14. Clientes con pedidos tanto para recoger como para consumir en el lugar
SELECT id_clientes
FROM pedidos
GROUP BY id_clientes
HAVING SUM(tipo_pedido = 'Recoger') > 0 AND SUM(tipo_pedido = 'En local') > 0;

- 15. Total de productos personalizados con adiciones
SELECT COUNT(DISTINCT id_pedido) AS pedidos_personalizados
FROM pedido_adicion;

- 16. Pedidos con más de 3 productos diferentes
SELECT id_pedido, COUNT(DISTINCT id_producto) AS cantidad
FROM pedido_producto
GROUP BY id_pedido
HAVING cantidad > 3;

- 17. Promedio de ingresos generados por día
SELECT AVG(total) AS promedio_diario
FROM (
  SELECT DATE(FROM_UNIXTIME(fecha)) AS fecha_dia, SUM(total) AS total
  FROM pedidos
  GROUP BY fecha_dia
) AS sub;

- 18. Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos
SELECT c.nombre, COUNT(DISTINCT pa.id_pedido)/COUNT(DISTINCT p.id_pedido)*100 AS porcentaje
FROM clientes c
JOIN pedidos p ON p.id_clientes = c.id_cliente
LEFT JOIN pedido_adicion pa ON pa.id_pedido = p.id_pedido
JOIN pedido_producto pp ON pp.id_pedido = p.id_pedido
JOIN productos pr ON pr.id_producto = pp.id_producto
WHERE pr.tipo = 'Pizza'
GROUP BY c.id_cliente
HAVING porcentaje > 50;

- 19. Porcentaje de ventas provenientes de productos no elaborados
SELECT 
  (SUM(CASE WHEN pr.tipo IN ('Bebida','Postre') THEN pp.precio*pp.cantidad ELSE 0 END) / SUM(pp.precio*pp.cantidad)) * 100 AS porcentaje_no_elaborados
FROM pedido_producto pp
JOIN productos pr ON pr.id_producto = pp.id_producto;

- 20. Día de la semana con mayor número de pedidos para recoger
SELECT DAYNAME(FROM_UNIXTIME(fecha)) AS dia, COUNT(*) AS total
FROM pedidos
WHERE tipo_pedido = 'Recoger'
GROUP BY dia
ORDER BY total DESC
LIMIT 1;


**Este modelo se preparado para futuras expansiones con relaciones muchos a muchos.

Todas las consultas suponen la existencia de tablas intermedias como pedido_producto o pedido_adicion si se desea un análisis completo.**