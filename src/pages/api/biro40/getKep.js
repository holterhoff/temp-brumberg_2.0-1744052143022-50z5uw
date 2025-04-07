'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getKep(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      // Grundabfrage
      let query = `
        SELECT DISTINCT
          KEP_ID,
          PRO_BASE_ID,
          GTR_BASE_ID,
          OPT_BASE_ID,
          KSED_ID,
          VERB_ID,
          BEFE_ID,
          ESPE_ID,
          MIN,
          EULUM,
          BERECHNUNGSLAENGE,
          LUMEN_M_DIREKT,
          LUMEN_M_INDIREKT,
          LUMEN_M_GESAMT,
          LEISTUNG_M_DIREKT,
          LEISTUNG_M_INDIREKT,
          LEISTUNG_M_GESAMT,
          LUMEN_PRO_WATT_M,
          EULUMDAT_BASIS,
          HEADERBILD,
          PRODUKTBILD,
          SKIZZE,
          POLARDIAGRAMM,
          SVG_IMAGE,
          SSC_INPUT_1,
          SSC_INPUT_2,
          SSC_INPUT_3,
          SSC_INPUT_4,
          SSC_INPUT_5,
          SSC_INPUT_6,
          SSC_INPUT_7,
          SSC_INPUT_8,
          SSC_INPUT_9,
          SSC_INPUT_10



        FROM biro40_kep
        WHERE 1=1

      `

      // Dynamische Filter aus params hinzufügen
      if (Array.isArray(params)) {
        params.forEach(element => {
          if (element.label === 'FIGUR') {
            query += ` AND FIGUR = '${element.value}'`
          }
          if (element.label === 'MONTAGEART') {
            query += ` AND MONTAGEART = '${element.value}'`
          }
          if (element.label === 'GEHÄUSEFARBE') {
            query += ` AND GEHAEUSEFARBE = '${element.value}'`
          }
          if (element.label === 'LICHTFARBE') {
            query += ` AND LICHTFARBE = '${element.value}'`
          }
          if (element.label === 'ANSTEUERUNG') {
            query += ` AND ANSTEUERUNG = '${element.value}'`
          }
          if (element.label === 'OPTISCHESSYSTEM') {
            query += ` AND OPTISCHES_SYSTEM = '${element.value}'`
          }
        })
      }

      // Abfrage beenden
      query += ' ORDER BY 1'

      // Abfrage ausführen
      const result = await sql(query)

      if (result.length > 0) {
        res.status(200).json(result)
      } else {
        res.status(404).json({ message: 'Keine Ergebnisse gefunden.' })
      }
    } catch (error) {
      console.error('Fehler beim Abrufen von KEP:', error)
      res.status(500).json({ message: 'Interner Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
