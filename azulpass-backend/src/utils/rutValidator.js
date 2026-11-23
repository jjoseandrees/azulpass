/**
 * Valida un RUT chileno usando el algoritmo módulo 11.
 * @param {string} rut - RUT en formato "12.345.678-9" o "12345678-9"
 * @returns {boolean} true si el RUT es válido
 */
function validateRut(rut) {
  if (!rut || typeof rut !== 'string') return false;

  // Limpiar el RUT: quitar puntos, guión y espacios
  const cleanRut = rut.replace(/\./g, '').replace(/-/g, '').replace(/\s/g, '').toUpperCase();

  // Validar formato: debe tener al menos 2 caracteres (cuerpo + dígito verificador)
  if (cleanRut.length < 2) return false;

  // Separar cuerpo y dígito verificador
  const body = cleanRut.slice(0, -1);
  const dv = cleanRut.slice(-1);

  // Validar que el cuerpo sea solo números
  if (!/^\d+$/.test(body)) return false;

  // Validar que el dígito verificador sea número o K
  if (!/^[0-9K]$/.test(dv)) return false;

  // Calcular dígito verificador esperado
  let sum = 0;
  let multiplier = 2;

  // Recorrer el cuerpo de derecha a izquierda
  for (let i = body.length - 1; i >= 0; i--) {
    sum += parseInt(body[i]) * multiplier;
    multiplier = multiplier === 7 ? 2 : multiplier + 1;
  }

  const remainder = 11 - (sum % 11);
  let expectedDv;

  if (remainder === 11) expectedDv = '0';
  else if (remainder === 10) expectedDv = 'K';
  else expectedDv = remainder.toString();

  return dv === expectedDv;
}

/**
 * Formatea un RUT limpio al formato chileno estándar: XX.XXX.XXX-X
 * @param {string} rut - RUT limpio (sin puntos ni guión)
 * @returns {string} RUT formateado
 */
function formatRut(rut) {
  const cleanRut = rut.replace(/\./g, '').replace(/-/g, '').replace(/\s/g, '').toUpperCase();
  
  if (cleanRut.length < 2) return rut;

  const body = cleanRut.slice(0, -1);
  const dv = cleanRut.slice(-1);

  // Agregar puntos de miles
  let formattedBody = '';
  for (let i = body.length - 1, count = 0; i >= 0; i--, count++) {
    if (count > 0 && count % 3 === 0) {
      formattedBody = '.' + formattedBody;
    }
    formattedBody = body[i] + formattedBody;
  }

  return `${formattedBody}-${dv}`;
}

module.exports = { validateRut, formatRut };