'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getGehaeuseform(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      // Grundabfrage für Gehäuseform
      let query = `
        SELECT DISTINCT form_de AS value_de, form_en AS value_en
        FROM m1
        WHERE 1=1
      `

      // SQL-Abfrage sicher ausführen
      const result = await sql(query)

      if (result.length > 0) {
        res.status(200).json(result)
      } else {
        res.status(404).json({ message: 'Keine Ergebnisse gefunden.' })
      }
    } catch (error) {
      console.error('Fehler beim Abrufen der Gehäuseform:', error)
      res.status(500).json({ message: 'Interner Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
