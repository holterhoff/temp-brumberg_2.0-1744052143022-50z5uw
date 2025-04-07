'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getLichtfarbe(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      // Grundabfrage
      let query = `
        SELECT DISTINCT lichtfarbe as value_DE
        FROM biro40_Kep
        WHERE 1=1
        AND lichtfarbe not like '%6500%'
      `

      // Dynamische Filter hinzufügen
      if (Array.isArray(params)) {
        params.forEach(element => {
          if (element.label === 'FIGUR') {
            query += ` AND figur = '${element.value}'`
          }
          if (element.label === 'MONTAGEART') {
            query += ` AND montageart = '${element.value}'`
          }
          if (element.label === 'GEHÄUSEFARBE') {
            query += ` AND gehaeusefarbe = '${element.value}'`
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
      console.error('Fehler beim Abrufen der Lichtfarbe:', error)
      res.status(500).json({ message: 'Interner Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
