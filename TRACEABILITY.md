# Trazabilidad de la app móvil · HU, CA y CP

**Fecha de corte:** 2026-09-28, al cierre del bloque "Recorrido en el celular y cierre chico" (rama `feature/mobile-device-run-closure`).

**Fuentes:** el backlog de `docs/04-product-backlog/product-backlog.csv` (HU y CA), las referencias a CP en el código, las pruebas y `DECISIONS-BLOCK-MOBILE-1.md`, y el recorrido en el Redmi Note 13 (Android 15) contra el backend `v0.13.0-portal-ready-1` del 2026-09-27 y el 2026-09-28.

**Qué significa cada estado:**

| Estado | Significado |
|---|---|
| Verificado | Construido, con pruebas, y recorrido en el celular contra el backend real |
| Construido | Construido y con pruebas, pero no recorrido en el celular en este bloque |
| Parcial | Una parte del CA o del CP queda afuera, por decisión registrada o por un gap |
| Pendiente | No construido |

**Aviso sobre el backlog.** La columna "Estado" del CSV está desactualizada: marca como "No se ha iniciado" a US12, US13, US14, US15, US16, US20, US23 y US24, que la app ya implementa. Esta tabla refleja el código, no el CSV.

**Los textos de los CP no están en ningún repo.** Los números salen de las referencias del código. Donde un CP no tiene referencia, se indica.

---

## 1. HU de la app del paciente

| HU | Título | Estado | CA | CP | Notas |
|---|---|---|---|---|---|
| US01 | Registro de paciente | Construido | CA01 a CA04 | CP004 | CP004 (comprobante del consentimiento) se cerró en el bloque de HU0001 escenario 4 |
| US03 | Perfil clínico inicial | Parcial | CA01, CA02, CA04, CA05 construidos. **CA03 pendiente** | CP011, CP071 | CA03 es la edición posterior del perfil: pendiente, igual que CP071 (fuera de alcance del bloque) |
| US04 | Línea base IBS-SSS | Construido | CA01, CA02 | Sin referencia | |
| US05 | Inicio de sesión del paciente | Verificado | CA01, CA02 | Sin referencia | Regresión del cambio de `/auth/login` de la v1.6.0: login y logout verificados tres veces. Otro `clientId` responde 400 `unsupported_client` |
| US07 | Recuperación de contraseña | Construido | CA01, CA02 | Sin referencia | |
| US08 | Cierre de sesión seguro | Verificado | CA01, CA02 | CP020 | Con su confirmación, desde Perfil y desde Ajustes |
| US09 | Registro de comidas | Verificado | CA01 a CA03 | CP022, CP023, CP024, CP076 | CP023 (modo avión): "Pendiente de sincronizar" pasó sola a "Sincronizado" al volver la red. Media taza se lee "0.5 tazas" |
| US10 | Alimentos personalizados | Construido | CA01 a CA03 | CP025, CP026, CP027 | |
| US11 | Síntomas e intensidad | Construido | CA01, CA02 | CP028, CP029 | |
| US12 | Cuestionario IBS-SSS periódico | Parcial | CA01, CA03, CA04 construidos. **CA02 parcial** | CP030, CP032, CP033, CP061 | CA02 pide un recordatorio: la app lo da con el aviso de Inicio y el candado del FAB, sin push (actas M13 y M37). El próximo ciclo del paciente demo vence el 2026-10-02 |
| US13 | Notas clínicas de contexto | Verificado | CA01, CA02 | CP034, CP035 | Guardada con 201 en el celular (acta M48) |
| US14 | Recepción de recomendación | Parcial | CA01, CA03, CA04 verificados. **CA02 parcial** | CP036, CP037, CP038, CP039 | CA02 pide avisar la espera en revisión: hay aviso en Inicio, sin push y **sin tiempo estimado** porque el backend no lo calcula (CP037, acta M47). CP039 sin referencia en el código |
| US15 | Explicabilidad (XAI) | Verificado | CA01 a CA03 | CP040, CP041, CP042, CP077 | Confianza con su explicación, nota del nutricionista, cuatro bloques y la explicación de respaldo con Ollama apagado. El código cita un "HU0015 CA4" (la explicación de respaldo) que el CSV no tiene: sale del backlog en PDF, que es más nuevo |
| US16 | Retroalimentación | Parcial | CA01 verificado. **CA02 no cubierto** | CP043, CP044 | CA02 pide guardar la respuesta sin conexión. El acta M47 (decisión 9) la dejó **solo en línea**. Es una decisión vigente, no un defecto |
| US20 | Vinculación por código de invitación | Construido | CA02 | Sin referencia | Canje post-registro (Mobile-1.5) |
| US23 | Gráficos de evolución | Verificado | CA01 verificado. CA02 construido | CP060, CP061 | CA02 (una sola evaluación) no se vio en el celular: el paciente demo ya tiene tres. El eje X reparte los puntos por orden y no por fecha (desvío de diseño, pendiente de decisión) |
| US24 | Reporte PDF personal | Verificado | CA01 verificado. CA02 construido | CP062, CP063 | PDF generado, descargado y abierto con la contraseña de Mailpit. **Gap del backend:** deja afuera lo registrado después de las 19:00 de Lima |
| US25 | Descarga de datos personales | Verificado | CA01, CA02 | CP064, CP065 | |
| US26 | Eliminación de cuenta | Verificado | CA01, CA02 | CP066, CP067 | Recorrido hasta el aviso del piloto y cancelado (no se borró al paciente demo). El 409 `active_pilot_retention` y el reintento con acuse, cubiertos por pruebas (acta M49) |
| US27 | Glosario | Verificado | CA01, CA02 | CP068, CP069 | |
| US28 | Perfil de paciente | Parcial | CA01 verificado. **CA02 pendiente** | CP070, CP071 | CP070: código `PAC-0001` y "Alergias declaradas: Ninguna". CA02 y CP071 son la edición, fuera de alcance |

## 2. CP pendientes conocidos

Los que el prompt del bloque declaró pendientes, con lo que se sabe de cada uno:

| CP | HU | Situación |
|---|---|---|
| CP021 | Sin referencia en el código | Sin texto disponible en el repo |
| CP037 | US14 | Parcial: aviso sin tiempo estimado (el backend no lo calcula) |
| CP039 | US14 | Sin referencia en el código |
| CP043 | US16 | La respuesta se envía y queda su resumen (verificado). El recordatorio a las 24 h depende del push |
| CP044 | US16 | Sin detalle en el código más allá del acta M47 |
| CP071 | US03, US28 | Edición del perfil: pendiente |
| CP075 | Sin referencia en el código | Sin texto disponible en el repo |
| CP078 | Sin referencia en el código | Sin texto disponible en el repo |

## 3. HU fuera del alcance de la app

Las resuelve el backend o el portal del nutricionista: TS01 a TS12, US02, US06, US17, US18, US19, US21, US22, US29 y US30. La app **consume** el resultado de US17 y US29 (recomendaciones aprobadas, modificadas y manuales), verificado en el celular con datos creados por API.

## 4. Gaps del backend encontrados en el recorrido

Quedan asignados al próximo bloque de Quinua-Backend. La app no los esquiva.

| Gap | Efecto | HU |
|---|---|---|
| El período del reporte se corta en días UTC | Lo registrado después de las 19:00 de Lima no sale en el PDF de ese día | US24 |
| El PDF muestra valores internos en inglés ("Breakfast", "Bloating", "Mild", "IbsD") y "1 episodios" | El paciente lee términos que no entiende | US24 |
| El catálogo tiene "Aji de gallina" sin tilde | Se ve así en el Diario, el buscador y el PDF | US09 |
| Los correos tratan al paciente de "usted" | La app lo trata de "tú" | US24, US07 |
| **Resuelto:** `GET /meals` ya devuelve `aggregatedFodmap` | El badge FODMAP del Diario, que el acta M42 daba por invisible, ahora aparece | US09 |
