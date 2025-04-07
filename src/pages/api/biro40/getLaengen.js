'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getLaengen(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      let schenkel = params.schenkel
      let basismass = params.basismass

      // Schenkel umwandeln
      switch (schenkel) {
        case 'OA':
          schenkel = 'OAC'
          break
        case 'OB':
          schenkel = 'OBD'
          break
        default:
          break
      }

      // SQL-Abfrage mit dynamischen Parametern
      let query = `
        SELECT DISTINCT ${schenkel} as value_de
        FROM biro40_laengen
        WHERE 1=1
        AND basismass >= ${basismass}
        ORDER BY 1 ASC
      `

      // Abfrage ausführen
      const result = await sql(query)

      if (result.length > 0) {
        res.status(200).json(result)
      } else {
        res.status(404).json({ message: 'Keine Ergebnisse gefunden.' })
      }
    } catch (error) {
      console.error('Fehler beim Abrufen der Längen:', error)
      res.status(500).json({ message: 'Interner Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
