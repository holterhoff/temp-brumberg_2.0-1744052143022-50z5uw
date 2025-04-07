'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getAnzahlLeuchtmittel(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      // Grundabfrage
      let query = `
        SELECT DISTINCT anzahl_leuchtmittel AS value_de, anzahl_leuchtmittel AS value_en
        FROM m1
        WHERE 1=1
      `

      params.forEach(element => {
        if (element.label == 'Form') {
          let form = element.value
          query += " AND (form_de = '" + form + "' OR form_en = '" + form + "')"
        }
      })

      query += ' ORDER BY 1'
      // Abfrage ausführen mit sicherem Parameter-Ersatz

      const result = await sql(query)

      if (result.length > 0) {
        res.status(200).json(result)
      } else {
        res.status(404).json({ message: 'Keine Ergebnisse gefunden.' })
      }
    } catch (error) {
      console.error('Fehler beim Abrufen der Leuchtmittel:', error)
      res.status(500).json({ message: 'Interner Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
