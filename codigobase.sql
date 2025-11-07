CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    direccion VARCHAR(150),
    telefono INT
);
CREATE TABLE ingrediente (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    unidad INT
);
CREATE TABLE adiciones (
    id_adiciones INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio BIGINT,
    id_ingrediente INT,
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
);
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255),
    tipo VARCHAR(100),
    precio BIGINT,
    nombre VARCHAR(100)
);
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha INT,
    hora INT,
    total INT,
    id_clientes INT,
    FOREIGN KEY (id_clientes) REFERENCES clientes(id_cliente)
);
CREATE TABLE combo (
    id_combo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(255),
    precio BIGINT
);
CREATE TABLE menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    fecha_inicial INT,
    fecha_final INT,
    nombre VARCHAR(100)
);