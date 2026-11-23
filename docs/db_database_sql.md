-- =============================================================================
-- AZULPASS - SCRIPT DE CREACIÓN DE BASE DE DATOS Y SEEDERS INICIALES
-- Motor: PostgreSQL 14+
-- Descripción: Estructura de tablas para gestión de partidos, sectores,
--              compradores y emisión transaccional de entradas.
-- =============================================================================

-- Eliminar tablas si existen (para ejecuciones limpias de prueba)
DROP TABLE IF EXISTS tickets CASCADE;
DROP TABLE IF EXISTS buyers CASCADE;
DROP TABLE IF EXISTS sectors CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- -----------------------------------------------------------------------------
-- 1. Tabla de Usuarios (Administración y Autenticación)
-- -----------------------------------------------------------------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------------------------------
-- 2. Tabla de Partidos (Matches)
-- -----------------------------------------------------------------------------
CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    home_team VARCHAR(100) NOT NULL,
    away_team VARCHAR(100) NOT NULL,
    match_date TIMESTAMP WITH TIME ZONE NOT NULL,
    stadium VARCHAR(150) NOT NULL,
    city VARCHAR(100) NOT NULL,
    status VARCHAR(50) DEFAULT 'scheduled', -- 'scheduled', 'in_progress', 'completed', 'cancelled'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------------------------------
-- 3. Tabla de Sectores por Estadio (Sectors)
-- -----------------------------------------------------------------------------
CREATE TABLE sectors (
    id SERIAL PRIMARY KEY,
    match_id INT NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    total_capacity INT NOT NULL CHECK (total_capacity > 0),
    available_tickets INT NOT NULL CHECK (available_tickets >= 0),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_availability CHECK (available_tickets <= total_capacity)
);

-- -----------------------------------------------------------------------------
-- 4. Tabla de Compradores (Buyers - Tratamiento de datos bajo Ley 21.719)
-- -----------------------------------------------------------------------------
CREATE TABLE buyers (
    id SERIAL PRIMARY KEY,
    rut VARCHAR(12) NOT NULL UNIQUE, -- Formato formateado: 12.345.678-K
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------------------------------
-- 5. Tabla de Entradas Emitidas (Tickets)
-- -----------------------------------------------------------------------------
CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    ticket_code VARCHAR(50) NOT NULL UNIQUE,
    match_id INT NOT NULL REFERENCES matches(id),
    sector_id INT NOT NULL REFERENCES sectors(id),
    buyer_id INT NOT NULL REFERENCES buyers(id),
    unit_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'issued', -- 'issued', 'used', 'cancelled'
    purchased_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------------------------------
-- ÍNDICES PARA OPTIMIZAR BÚSQUEDAS Y TRANSACCIONES CONCURRENTES
-- -----------------------------------------------------------------------------
CREATE INDEX idx_matches_date ON matches(match_date);
CREATE INDEX idx_sectors_match ON sectors(match_id);
CREATE INDEX idx_buyers_rut ON buyers(rut);
CREATE INDEX idx_tickets_code ON tickets(ticket_code);
CREATE INDEX idx_tickets_buyer ON tickets(buyer_id);

-- -----------------------------------------------------------------------------
-- DATOS INICIALES DE PRUEBA (SEEDERS)
-- -----------------------------------------------------------------------------

-- Usuario administrador (Password de prueba cifrada con bcrypt para 'Password123!')
INSERT INTO users (email, password_hash, full_name, role) VALUES 
('admin@azulpass.cl', '$2b$10$E9qB7Jz5hW/1z4h7VwY.p.a8jM.N/vG9r2k7LqV7WzY1z4h7VwY.p', 'Administrador AzulPass', 'admin'),
('hincha@ejemplo.cl', '$2b$10$E9qB7Jz5hW/1z4h7VwY.p.a8jM.N/vG9r2k7LqV7WzY1z4h7VwY.p', 'José Andrés García', 'user');

-- Partidos de prueba
INSERT INTO matches (home_team, away_team, match_date, stadium, city, status) VALUES 
('Universidad de Chile', 'Colo-Colo', '2026-12-05 18:00:00-03', 'Estadio Nacional Julio Martínez Prádanos', 'Santiago', 'scheduled'),
('Universidad de Chile', 'Universidad Católica', '2026-12-12 15:00:00-03', 'Estadio Nacional Julio Martínez Prádanos', 'Santiago', 'scheduled'),
('Universidad de Chile', 'Everton', '2026-12-19 20:00:00-03', 'Estadio Santa Laura', 'Santiago', 'scheduled');

-- Sectores y capacidades para el Partido 1 (Superclásico)
INSERT INTO sectors (match_id, name, total_capacity, available_tickets, price) VALUES 
(1, 'Galería Sur', 12000, 11998, 10000.00),
(1, 'Galería Norte (Visita)', 4000, 4000, 10000.00),
(1, 'Andes', 8000, 7995, 25000.00),
(1, 'Bajo Marquesina / Tribuna Presidencial', 1500, 1490, 60000.00);

-- Sectores para el Partido 2
INSERT INTO sectors (match_id, name, total_capacity, available_tickets, price) VALUES 
(2, 'Galería Sur', 12000, 12000, 10000.00),
(2, 'Andes', 8000, 8000, 22000.00);

-- Comprador inicial de prueba
INSERT INTO buyers (rut, full_name, email, phone) VALUES 
('12.345.678-5', 'José Andrés García', 'j.garcia@ejemplo.cl', '+56912345678');

-- Entradas emitidas inicialmente para verificar lecturas
INSERT INTO tickets (ticket_code, match_id, sector_id, buyer_id, unit_price, status) VALUES 
('TCK-20261205-001-A8F2', 1, 1, 1, 10000.00, 'issued'),
('TCK-20261205-002-B9X4', 1, 1, 1, 10000.00, 'issued');