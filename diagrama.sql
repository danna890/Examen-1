CREATE TABLE `clientes`(
    `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `apellido` VARCHAR(255) NOT NULL,
    `direccion` VARCHAR(255) NOT NULL,
    `telefono` INT NOT NULL
);
CREATE TABLE `productos`(
    `id_producto` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `descripcion` VARCHAR(255) NOT NULL,
    `tipo` VARCHAR(255) NOT NULL,
    `precio` INT NOT NULL,
    `nombre` VARCHAR(255) NOT NULL
);
CREATE TABLE `pedidos`(
    `id_pedido` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha` INT NOT NULL,
    `hora` INT NOT NULL,
    `total` INT NOT NULL,
    `id_clientes` INT NOT NULL
);
CREATE TABLE `ingrediente`(
    `id_ingrediente` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `unidad` INT NOT NULL
);
CREATE TABLE `adiciones`(
    `id_adiciones` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` BIGINT NOT NULL,
    `precio` BIGINT NOT NULL,
    `id_ingrediente` BIGINT NOT NULL
);
CREATE TABLE `combo`(
    `id_combo` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` BIGINT NOT NULL,
    `descripcion` BIGINT NOT NULL,
    `precio` BIGINT NOT NULL
);
CREATE TABLE `menu`(
    `id_menu` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha_inicial` INT NOT NULL,
    `fecha_final` INT NOT NULL,
    `nombre` VARCHAR(255) NOT NULL
);
CREATE TABLE `pedido_producto`(
    `id_pedido` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_producto` BIGINT NOT NULL,
    `cantidad` BIGINT NOT NULL,
    `precio` BIGINT NOT NULL
);
CREATE TABLE `pedido_adicion`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_pedido` BIGINT NOT NULL,
    `id_adicion` BIGINT NOT NULL
);
CREATE TABLE `producto_ingrediente`(
    `id_producto` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_cliente` BIGINT NOT NULL
);
CREATE TABLE `producto_combo`(
    `id_producto` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_combo` BIGINT NOT NULL
);
CREATE TABLE `menu_producto`(
    `id_menu` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_producto` BIGINT NOT NULL
);
CREATE TABLE `menu_combo`(
    `id_menu` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_combo` INT NOT NULL
);
ALTER TABLE
    `menu_combo` ADD CONSTRAINT `menu_combo_id_menu_foreign` FOREIGN KEY(`id_menu`) REFERENCES `menu`(`id_menu`);
ALTER TABLE
    `menu_producto` ADD CONSTRAINT `menu_producto_id_producto_foreign` FOREIGN KEY(`id_producto`) REFERENCES `productos`(`id_producto`);
ALTER TABLE
    `pedido_adicion` ADD CONSTRAINT `pedido_adicion_id_pedido_foreign` FOREIGN KEY(`id_pedido`) REFERENCES `pedidos`(`id_pedido`);
ALTER TABLE
    `pedido_adicion` ADD CONSTRAINT `pedido_adicion_id_adicion_foreign` FOREIGN KEY(`id_adicion`) REFERENCES `adiciones`(`id_adiciones`);
ALTER TABLE
    `producto_ingrediente` ADD CONSTRAINT `producto_ingrediente_id_cliente_foreign` FOREIGN KEY(`id_cliente`) REFERENCES `ingrediente`(`id_ingrediente`);
ALTER TABLE
    `pedido_producto` ADD CONSTRAINT `pedido_producto_id_producto_foreign` FOREIGN KEY(`id_producto`) REFERENCES `productos`(`id_producto`);
ALTER TABLE
    `producto_combo` ADD CONSTRAINT `producto_combo_id_combo_foreign` FOREIGN KEY(`id_combo`) REFERENCES `combo`(`id_combo`);
ALTER TABLE
    `pedidos` ADD CONSTRAINT `pedidos_id_clientes_foreign` FOREIGN KEY(`id_clientes`) REFERENCES `clientes`(`id_cliente`);
ALTER TABLE
    `producto_combo` ADD CONSTRAINT `producto_combo_id_producto_foreign` FOREIGN KEY(`id_producto`) REFERENCES `productos`(`id_producto`);
ALTER TABLE
    `menu_combo` ADD CONSTRAINT `menu_combo_id_combo_foreign` FOREIGN KEY(`id_combo`) REFERENCES `combo`(`id_combo`);
ALTER TABLE
    `menu_producto` ADD CONSTRAINT `menu_producto_id_menu_foreign` FOREIGN KEY(`id_menu`) REFERENCES `menu`(`id_menu`);
ALTER TABLE
    `producto_ingrediente` ADD CONSTRAINT `producto_ingrediente_id_producto_foreign` FOREIGN KEY(`id_producto`) REFERENCES `productos`(`id_producto`);
ALTER TABLE
    `pedido_producto` ADD CONSTRAINT `pedido_producto_id_pedido_foreign` FOREIGN KEY(`id_pedido`) REFERENCES `pedidos`(`id_pedido`);