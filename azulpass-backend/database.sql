-- Crear base de datos
CREATE DATABASE azulpass;

-- Conectarse a azulpass
\c azulpass;

-- Tabla de partidos
CREATE TABLE matches (
  id SERIAL PRIMARY KEY,
  home_team VARCHAR(100) NOT NULL,
  away_team VARCHAR(100) NOT NULL,
  match_date TIMESTAMP NOT NULL,
  stadium VARCHAR(100) NOT NULL,
  competition VARCHAR(100) NOT NULL,
  status VARCHAR(20) DEFAULT 'upcoming',
  requirements TEXT[],
  sale_phases TEXT[],
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de sectores
CREATE TABLE sectors (
  id SERIAL PRIMARY KEY,
  match_id INTEGER REFERENCES matches(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  is_available BOOLEAN DEFAULT true,
  capacity INTEGER NOT NULL,
  sold INTEGER DEFAULT 0
);

-- Tabla de compradores (SOLO RUT, como dice el PDF)
CREATE TABLE buyers (
  id SERIAL PRIMARY KEY,
  rut VARCHAR(12) UNIQUE NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20),
  has_hinchas_registry BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de entradas
CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  match_id INTEGER REFERENCES matches(id),
  sector_id INTEGER REFERENCES sectors(id),
  buyer_id INTEGER REFERENCES buyers(id),
  quantity INTEGER NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  qr_code VARCHAR(255) UNIQUE NOT NULL,
  purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) DEFAULT 'active'
);

-- Índices para rendimiento
CREATE INDEX idx_matches_date ON matches(match_date);
CREATE INDEX idx_tickets_buyer ON tickets(buyer_id);
CREATE INDEX idx_sectors_match ON sectors(match_id);

-- Datos de ejemplo
INSERT INTO matches (home_team, away_team, match_date, stadium, competition, status, requirements, sale_phases)
VALUES 
(
  'Universidad de Chile', 
  'Everton de Viña del Mar', 
  '2026-10-26 19:00:00', 
  'Estadio Nacional', 
  'Primera División', 
  'upcoming',
  ARRAY['Registro Nacional de Hinchas obligatorio', 'Cédula de identidad con chip legible'],
  ARRAY['Preventa Socios: 20/10 10:00 hrs', 'Venta General: 22/10 10:00 hrs']
),
(
  'Universidad Católica', 
  'Universidad de Chile', 
  '2026-11-01 20:00:00', 
  'Claro Arena', 
  'Primera División', 
  'upcoming',
  ARRAY['Registro Nacional de Hinchas obligatorio'],
  ARRAY['Venta General: 25/10 10:00 hrs']
);

-- Sectores para el primer partido
INSERT INTO sectors (match_id, name, price, is_available, capacity, sold)
VALUES 
(1, 'Galería Andes', 15000, true, 5000, 0),
(1, 'Galería Pacífico', 15000, true, 5000, 0),
(1, 'Preferencia', 25000, true, 3000, 0),
(1, 'Tribuna', 35000, false, 2000, 2000);

-- Sectores para el segundo partido
INSERT INTO sectors (match_id, name, price, is_available, capacity, sold)
VALUES 
(2, 'Visita - Galería', 18000, true, 1000, 0);