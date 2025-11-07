/* Crear la tabla combo */ 

insert into combo(nombre) values ('combo familiar');

select * from combo;

insert into combo(nombre, precio) values ('combo familiar', 25.000);

select * from combo;

insert into combo(nombre, descripcion, precio) values ('combo familiar', 'Combo para 4 personas', 25000);

select * from combo;

/* Crear la tabla menu */

insert into menu(nombre) values ('menu del dia');

select * from menu;

insert into menu(nombre, fecha_inicial, fecha_final) values ('menu del dia', 20240601, 20240630);

select * from menu;

/* Productos */

insert into productos(nombre) values ('hamburguesa');

select * from productos;

insert into productos(nombre, descripcion, tipo, precio) values ('hamburguesa', 'Hamburguesa con queso y lechuga', 'comida', 15000);

select * from productos;

/* Ingredientes */

insert into ingrediente(nombre) values ('lechuga');

select * from ingrediente;

insert into ingrediente(nombre, unidad) values ('lechuga', 1);

select * from ingrediente;

/* Adiciones */

insert into adiciones(nombre) values ('queso extra');

select * from adiciones;

insert into adiciones(nombre, precio, id_ingrediente) values ('queso extra', 3000, 1);

select * from adiciones;

/* Clientes */

insert into clientes(nombre) values ('Juan');

select * from clientes;

insert into clientes(nombre, apellido, direccion, telefono) values ('Juan', 'Perez', 'Calle 123', 123456789);

select * from clientes;

/* Pedidos */

insert into pedidos(fecha, hora, total, id_clientes) values (20240615, 1230, 18000, 1);

select * from pedidos;

/* se revisa*/

