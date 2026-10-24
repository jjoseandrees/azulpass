class InfoMockDataSource {
  Future<Map<String, dynamic>> getStadiumInfo() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      "name": "Estadio Nacional Julio Martínez Prádanos",
      "address": "Av. Grecia 2001, Ñuñoa, Santiago",
      "transportOptions": [
        "Metro: Línea 3 - Estación Ñuñoa (salida sur)",
        "Metro: Línea 6 - Estación Estadio Nacional",
        "Buses: Múltiples líneas por Av. Grecia y Av. Irarrázaval",
        "Bicicleta: Cicloestacionamiento en puerta 4"
      ],
      "parkingInfo": [
        "Estacionamiento oficial: \$5.000 la hora",
        "Estacionamientos privados en Av. Grecia: \$3.000 - \$4.000",
        "Se recomienda llegar con anticipación (1 hora antes del partido)"
      ],
      "entryRequirements": [
        "Cédula de identidad con chip legible (obligatorio)",
        "Registro Nacional de Hinchas activo",
        "Entrada digital (QR) en la app o impresa",
        "No se permiten elementos cortopunzantes, bebidas alcohólicas ni pirotecnia"
      ]
    };
  }

  Future<List<Map<String, dynamic>>> getFAQs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        "id": "1",
        "question": "¿Cuándo se abren las puertas del estadio?",
        "answer": "Las puertas se abren 2 horas antes del inicio del partido. Se recomienda llegar con al menos 1 hora de anticipación.",
        "category": "ingreso"
      },
      {
        "id": "2",
        "question": "¿Qué pasa si pierdo mi entrada?",
        "answer": "Puedes recuperar tu entrada desde la sección 'Mis Entradas' en la app. También puedes solicitar un reenvío al correo registrado.",
        "category": "compra"
      },
      {
        "id": "3",
        "question": "¿Puedo transferir mi entrada a otra persona?",
        "answer": "No. Las entradas son personales e intransferibles. El nombre del comprador debe coincidir con el RUT registrado.",
        "category": "compra"
      },
      {
        "id": "4",
        "question": "¿Qué hago si mi cédula no tiene chip legible?",
        "answer": "Debes renovar tu cédula en el Registro Civil antes del partido. Sin cédula con chip legible no podrás ingresar al estadio.",
        "category": "ingreso"
      },
      {
        "id": "5",
        "question": "¿Hay devolución si se suspende el partido?",
        "answer": "Sí. Si el partido se suspende o posterga, se habilitará un período de devolución automática en la app dentro de los 5 días hábiles siguientes.",
        "category": "compra"
      },
      {
        "id": "6",
        "question": "¿Puedo ingresar con mochila o bolso?",
        "answer": "Sí, pero serán revisados en el control de seguridad. No se permiten bolsos grandes (más de 30x30x15 cm).",
        "category": "ingreso"
      }
    ];
  }
}