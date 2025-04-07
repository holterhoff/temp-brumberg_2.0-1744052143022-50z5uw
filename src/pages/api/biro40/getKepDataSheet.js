'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getKepDataSheet(req, res) {
  if (req.method === 'GET') {
    try {
      let idString = req.query.id
      let parts = idString.split('-')
      let id = parts[0]
      let figur = parts[1]

      // Grundabfrage
      let query = `
        SELECT DISTINCT
         *


        FROM biro40_kep
        WHERE 1=1
        AND KEP_ID = ${id}
        AND FIGUR_INDEX = '${figur}'

      `

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
